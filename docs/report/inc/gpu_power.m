#import <Foundation/Foundation.h>
#import <IOKit/IOKitLib.h>

bool gpuOpen();  // Initialize driver
void gpuClose(); // Close driver

// User client method dispatch selectors.
enum { kOpen, kClose, kmuxSet, kmuxGet };

typedef enum {
  muxFeatureInfo    = 0, // get: uint64_t with bits set as (1<<muxFeature)
  muxForceSwitch    = 2, // set: force graphics switching
  muxPowerGPU       = 3, // set: power down a gpu
                         // get: graphics cards?, 0x8=Intel, 0x88=Nvidia
  muxGpuSelect      = 4, // set/get: dynamic switching on=2/off=0
  muxSwitchPolicy   = 5, // set: 0=immediate, 2=requires logout to switch
  muxGraphicsCard   = 7, // get: returns active graphics card
} muxState;

typedef enum { Policy, Auto_PowerDown_GPU, Dynamic_Switching,
  GPU_Powerpolling, // Inverted: 1=off, 0=on
  Defer_Policy,
  Synchronous_Launch,
  Backlight_Control=8,
  Recovery_Timeouts,
  Power_Switch_Debounce,
  Logging=16,
} muxFeature;

static io_connect_t conn = IO_OBJECT_NULL;

#define muxCall(STATE,IN,IN_N,OUT,OUT_N) if (IOConnectCallScalarMethod(conn,STATE,IN,IN_N,OUT,OUT_N)!=KERN_SUCCESS) { perror("Mux error"); gpuClose(); exit(EXIT_FAILURE); }
static uint64_t muxGet(muxState state) { uint32_t count=1; uint64_t out,in[2]={1, (uint64_t)state}; muxCall(kmuxGet, in, 2, &out, &count); return out; }
static void muxSet(muxState state, uint64_t arg) { uint64_t in[3] = {1, (uint64_t) state, arg }; muxCall(kmuxSet, in, 3, NULL, NULL); }

#define setFeature(feature,enabled) muxSet(enabled,1<<(feature))
#define setDynamic(enabled) muxSet(muxGpuSelect,enabled)
#define setSwitchPolicy(immediate) muxSet(muxSwitchPolicy,immediate?0:2)

bool gpuOpen() {
  kern_return_t res;
  io_iterator_t iterator = IO_OBJECT_NULL;
  io_service_t gpuService = IO_OBJECT_NULL;

  res = IOServiceGetMatchingServices(kIOMasterPortDefault, IOServiceMatching("AppleGraphicsControl"), &iterator);
  if (res != KERN_SUCCESS) return NO;
  gpuService = IOIteratorNext(iterator); // Only 1 such service
  IOObjectRelease(iterator);
  if (gpuService == IO_OBJECT_NULL) return NO; // No drivers found

  res = IOServiceOpen(gpuService, mach_task_self(), 0, &conn);
  IOObjectRelease(gpuService);
  if (res != KERN_SUCCESS) return NO;

  muxCall(kOpen,NULL,0,NULL,NULL);
  return YES;
}

void gpuClose() { if (conn) { muxCall(kClose,NULL,0,NULL,NULL); IOServiceClose(conn); } }

// ---------------------------------------------------------------
// GCC FLAGS:= -Wall -O2 -F/System/Library/PrivateFrameworks -framework Foundation -framework IOKit

int main(int argc, char** argv) {
  int mode=0;
  if (argc>=2) {
    if (!strcmp(argv[1],"cuda")) mode=1; // GPU powered, UI on CPU
    if (!strcmp(argv[1],"auto")) mode=2; // Back to auto switching
    if (strstr(argv[1],"help")) { fprintf(stderr,"Usage: %s cuda | auto\n",argv[0]); return 0; }
  }
  // Open driver
  if (!gpuOpen()) { perror("Cannot connect"); return EXIT_FAILURE; }
  // Setup requested mode
  #define switchCards { muxSet(muxForceSwitch, 0); usleep(500*1000); }
  if (mode==1) { setFeature(Policy, NO); setDynamic(NO); }
  if (mode) {
    if (muxGet(muxGraphicsCard)) switchCards // switch to GPU
    setFeature(Auto_PowerDown_GPU, mode!=1); switchCards // back to CPU
  }
  if (mode==2) { setFeature(Policy, YES); setDynamic(YES); }
  // Display infos
  printf("AutoPowerDown: %s\n", muxGet(muxFeatureInfo) & (1<<Auto_PowerDown_GPU) ? "ON" : "OFF");
  printf("UI rendering : %s\n", muxGet(muxGraphicsCard) ? "CPU (integrated)" : "GPU (dedicated)");
  // Close driver
  gpuClose();
  return 0;
}
