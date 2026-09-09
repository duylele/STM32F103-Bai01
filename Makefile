# Tên chương trình output
TARGET = blink

# Bộ biên dịch cho ARM
CC      = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy

# Cờ biên dịch (Cortex-M3 cho STM32F1)
CFLAGS  = -mcpu=cortex-m3 -mthumb -Wall -g TARGET = blink

CC      = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy

CFLAGS  = -mcpu=cortex-m3 \
          -mthumb \
          -O0 \
          -Wall \
          -ffreestanding \
          -nostdlib

LDFLAGS = -T stm32f103.ld \
          -nostdlib \
          -Wl,--gc-sections

OBJS = main.o startup.o

# Target mặc định khi gõ "make"
all: $(TARGET).bin

# Rule biên dịch các file .c và .s
main.o: main.c
	$(CC) $(CFLAGS) -c main.c -o main.o

startup.o: startup.s
	$(CC) $(CFLAGS) -c startup.s -o startup.o

# Link tạo file .elf
$(TARGET).elf: $(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) -o $(TARGET).elf

# Chuyển .elf thành .bin (Đặt trước hoặc cùng luồng với all)
$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $(TARGET).elf $(TARGET).bin

# Lệnh nạp code
flash: $(TARGET).bin
	st-flash write $(TARGET).bin 0x8000000

# Lệnh dọn dẹp
clean:
	rm -f *.o *.elf *.bin

.PHONY: all clean flash
