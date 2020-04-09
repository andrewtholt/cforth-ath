

##To add a system level word.##

All paths are relative to ~/Source/Forth/cforth, unless otherwise stated.

Edit the file src/app/esp32/extend.c and add in the name of your new word e.g.

```C
C(athProcessInfo)   //c ps      { -- }
```

Then edit src/app/esp32/interface.h and define your C function:

```C
void athProcessInfo();
```

Now implement the function in build/esp32/sdk_build/main/interface.c

```C
void athProcessInfo() {
    char *ptr;

    ptr=malloc(1024);

    memset(ptr,0,1024);

    vTaskList(ptr);

    printf("Task\t\tState   Prio    Stack    Num\n");
    printf("%s\n", ptr);

    free(ptr);

}
```

now go to the build folder at build/esp32 and enter

```bash
COMPORT=/dev/ttyUSB3 make flash
```

This will build and program the target


