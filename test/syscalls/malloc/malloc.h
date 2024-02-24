#define align8(x) (((((x)-1) >> 3) << 3) + 8)

typedef struct mem_block
{
  size_t size;
} mem_block;

#define BLOCK_SIZE sizeof(mem_block)