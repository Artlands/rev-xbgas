#define align8(x) (((((x)-1) >> 3) << 3) + 8)
#define PAGE_SIZE 4096
#define MAX_SEGMENTS 1024

typedef struct mem_block
{ 
  // The order of the members should not be changed
  int free;
  size_t size;
  struct mem_block *next;
  struct mem_block *prev;
} mem_block;

typedef struct mem_segment
{
  uint64_t start;
  uint64_t end;
} mem_segment;

#define BLOCK_SIZE sizeof(mem_block)