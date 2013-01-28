typedef struct {
    char* name;
    char* description;
    void (*function)(Job* job);
} output_format_t;

extern output_format_t stage6_formats[];

void stage6(Job* job);