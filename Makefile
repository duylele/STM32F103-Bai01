TARGET = blink

CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy

CFLAGS = -mcpu=cortex-m3 \
         -mthumb \
         -O0 \
         -Wall \
         -ffreestanding \
         -nostdlib

LDFLAGS = -T stm32f103.ld \
          -nostdlib \
          -Wl,--gc-sections


all: $(TARGET).bin


main.o: main.c
	$(CC) $(CFLAGS) -c main.c -o main.o


startup.o: startup.s
	$(CC) $(CFLAGS) -c startup.s -o startup.o


$(TARGET).elf: main.o startup.o
	$(CC) $(CFLAGS) $(LDFLAGS) main.o startup.o -o $(TARGET).elf


$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $(TARGET).elf $(TARGET).bin


clean:
	rm -f *.o *.elf *.bin

