/* boot2.c の代わり
 */

#define KBD_STATUS    0x64
#define KBD_DATA      0x60
#define KEY_UP_BIT    0x80
#define SCREEN_WIDTH  320

/* 関数 boot2() より前に他の関数の定義(実装)や、大域変数宣言を書いてはいけない
 */

void boot2() {
  int i = 0;
	while ((in8(KBD_STATUS) & 1) == 0)
    ;

  int value = in8(KBD_DATA);
  int key = value & 0x7f;
  // if (value & KEY_UP_BIT) {    // if key up
  //   printv2(key, i);
  // }
  register_kbd_handler();
  while (1)
    halt();
  //halt();
}

/* 戻り値が int である関数は事前に宣言しなくても
   よいので、全ての関数の戻り値を int にしておく。
   適当な戻り値がない場合は 0 を返すことにする。
*/

int xpos = 100;

int kbd_handler() {
  out8(0x20, 0x61);	/* PIC0_OCW2: accept IRQ1 again */
  int value = in8(KBD_DATA);
	int key = value & 0x7f;

	if (value & KEY_UP_BIT)
	;
	else {
    printv2(key, xpos - 100);
		xpos += 1;
	}
}

/* 割り込み処理関数を登録する
 */
int register_kbd_handler() {
  int* ptr = (int*)0x7e00;
  *ptr = (int)kbd_handler;
  sti();
  out8(0x21, 0xf9);	/* PIC0_IMR: accept only IRQ1 and IRQ2 (PIC1) */
  out8(0xa1, 0xff);	/* PIC1_IMR: no interrupt */
}

int print(int num, int x, int y, int color) {
  static int bitmaps[][4] = {
    { 0x7e, 0x81, 0x81, 0x7e },	/* 0 */
    { 0x00, 0x41, 0xff, 0x01 },	/* 1 */
    { 0x47, 0x8d, 0x99, 0x71 }, /* 2 */
    { 0x99, 0x99, 0x99, 0xff }, /* 3 */
    { 0xf0, 0x10, 0x10, 0xff }, /* 4 */
    { 0xf1, 0x91, 0x91, 0x9f }, /* 5 */
    { 0xff, 0x89, 0x89, 0x8f }, /* 6 */
    { 0x80, 0x80, 0x80, 0xff }, /* 7 */
    { 0xff, 0x91, 0x91, 0xff }, /* 8 */
    { 0xf1, 0x91, 0x91, 0xff }  /* 9 */
  };

  int i, j;
  char* vram = (char*)0xa0000;
  int* map = bitmaps[num];
  vram += (y * SCREEN_WIDTH + x);

  for (i = 0; i < 8; i++) {
    for (j = 0; j < 4; j++) {
      int bits = map[j];
      if (bits & (0x80 >> i))
        *(vram + j) = color;
    }

    vram += SCREEN_WIDTH;
  }

  return 0;
}
int printv2(int key, int i){
  print(key % 10, 130, 50 + i * 10, 15);
  if(key % 100/10 != 0)
  print(key % 100/10, 120, 50 + i * 10, 15);
    if(key % 1000/100 != 0)
    print(key % 100/10, 120, 50 + i * 10, 15);
      if(key % 1000/100 != 0)
      print(key % 1000/100, 110, 50 + i * 10, 15);
 return 0;
}

/* in 命令で port の値 (8bit) を読む
 */
int in8(int port) {
  int value;
  asm volatile ("mov $0, %%eax\n\tin %%dx,%%al"
                : "=r" (value) : "d" (port));
  return value;
}

/* out 命令で port に値 (8bit) を書き込む
 */
int out8(int port, int value) {
  asm volatile ("out %%al,%%dx"
                : : "d" (port), "a" (value));
  return 0;
}

/* sti 命令 (割り込み許可) を実行
 */
int sti() {
  asm volatile ("sti");
  return 0;
}

/* cli 命令 (割り込み禁止) を実行
 */
int cli() {
  asm volatile ("cli");
  return 0;
}

/* hlt 命令でプロセッサを停止させる
 */
int halt() {
  asm volatile ("hlt");
  return 0;
}

/* sti 命令と hlt 命令を連続して実行
 * sti してから hlt までのわずかの時間に
 * 割り込みが発生しないようにする。
 */
int sti_and_halt() {
  asm volatile ("sti\n\thlt");
  return 0;
}
