# Bài tập 01 - STM32F103
# Nội dung
- Vi điều khiển: STM32F103C8T6
- Chân LED: PC13
- Cấu hình PC13 ở chế độ Output
- LED nhấp nháy mỗi 1 giây
- Có thể thay đổi tham số để thay đổi chu kỳ nhấp nháy
- Lập trình trên môi trường Linux
- Không sử dụng KeilC
# Các file
- `main.c`: Chương trình chính
- `startup.s`: Startup code
- `stm32f103.ld`: Linker script
- `Makefile`: File biên dịch
## Biên dịch và Nạp code
```bash
make clean
make
make flash
```
## Demo
https://drive.google.com/file/d/12v4vo7gRM2eIP9ThWWH9QB1blUiL9gf7/view?usp=sharing
