module aoc::y2024::day09;
import aoc::utils;
import std::io;
import std::collections;
import std::math;

def Disk = List(<long>);

struct FreeEntry
{
    usz start;
    usz size;
}

def FreeList = List(<FreeEntry>);

struct Block
{
    usz id;
    usz start;
    usz size;
}

def BlockList = List(<Block>);

fn void fill_disk(Disk *disk, BlockList *block_list, FreeList *free_list, String data)
{
    int block_id = 0;

    for (int i = 0; i < data.len; i += 2) {
        Block block = { block_id, disk.len(), 0 };
        
        int block_count = (int)(data[i] - '0');
        for (int j = 0; j < block_count; j++) {
            disk.push(block_id);
        }
        
        block.size = block_count;
        block_list.push(block);
        
        if (i < data.len-1) {
            int free_count = (int)(data[i+1] - '0');
            FreeEntry free_entry = { disk.len(), free_count };
            free_list.push(free_entry);
            for (int j = 0; j < free_count; j++) {
                disk.push(-1);
            }
        }

        block_id++;
    }
}

fn void compact_disk(Disk *disk)
{
    isz block_pos = disk.len()-1;
    int free_pos = 0;

    while (disk.get(free_pos) != -1) {
        free_pos++;
    }

    while (block_pos > free_pos) {
        disk.set(free_pos, disk.get(block_pos));
        disk.set(block_pos, -1);
        block_pos--;
        while (block_pos > 0 && disk.get(block_pos) == -1) {
            block_pos--;
        }
        free_pos++;
        while (free_pos < disk.len() && disk.get(free_pos) != -1) {
            free_pos++;
        }
    }
}

fn long disk_checksum(Disk *disk)
{
    int pos;
    long sum;

    while (pos < disk.len()) {
        if (disk.get(pos) != -1) {
            sum += pos * disk.get(pos);
        }
        pos++;
    }

    return sum;
}

fn String! part1()
{
    String input = utils::slurp("input/y2024/day09.txt")!;
    Disk disk;
    BlockList block_list;
    FreeList free_list;
    long checksum;

    disk.temp_init();
    block_list.temp_init();
    free_list.temp_init();

    fill_disk(&disk, &block_list, &free_list, input);
    compact_disk(&disk);
    checksum = disk_checksum(&disk);

    return string::tformat("%d", checksum);
}

fn void compact_disk_contiguous(Disk *disk, BlockList *block_list, FreeList *free_list)
{
    isz block_index = block_list.len()-1;
    
    while (block_index >= 0) {
        Block block = block_list.get(block_index);
        isz free_index;
        while (free_index < free_list.len()) {
            FreeEntry free_entry = free_list.get(free_index);
            if (block.start > free_entry.start && block.size <= free_entry.size) {
                for (int i = 0; i < block.size; i++) {
                    (*disk)[free_entry.start + i] = block.id;
                    (*disk)[block.start + i] = -1;
                }
                
                free_entry.start += block.size;
                free_entry.size -= block.size;
                
                if (free_entry.size > 0) {
                    free_list.set_at(free_index, free_entry);
                } else {
                    free_list.remove_at(free_index);
                }
                break;
            }
            
            free_index++;
        }
        
        block_index--;
    }
}

fn String! part2()
{
    String input = utils::slurp("input/y2024/day09.txt")!;
    Disk disk;
    BlockList block_list;
    FreeList free_list;
    long checksum;

    disk.temp_init();
    block_list.temp_init();
    free_list.temp_init();

    fill_disk(&disk, &block_list, &free_list, input);
    compact_disk_contiguous(&disk, &block_list, &free_list);
    checksum = disk_checksum(&disk);

    return string::tformat("%d", checksum);
}
