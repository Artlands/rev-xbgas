//
// _XBRTIME_UTIL_C_
//
// Copyright (C) 2017-2021 Tactical Computing Laboratories, LLC
// All Rights Reserved
// contact@tactcomplabs.com
//
// See LICENSE in the top level directory for licensing details
//

#include "xbrtime.h"

extern int xbrtime_decode_pe( int pe ) {
  int raw_pe = 0;
  int i = 0;
  int npes = (int)(*((uint64_t*)(_XBGAS_TOTAL_NPE_)));
  
  for( i = 0; i < npes; i++ ){ 
   if( (int)(*(uint64_t*)(_XBGAS_MAP_ + (uint64_t)(i * 16))) == pe )      // logical address
      return (int)(*(uint64_t*)(_XBGAS_MAP_ + (uint64_t)(i * 16 + 8)));   // physical address
  }
  return raw_pe;
}

extern int xbrtime_addr_accessible( const void *addr, int pe ){
  return 1;
}

void reverse_str(char *str, int len) {
  int i = 0, j = len - 1;
  while (i < j) {
    char temp = str[i];
    str[i] = str[j];
    str[j] = temp;
    i++;
    j--;
  }
}

int int_to_str(int num, char *str){
  int int_part = (int)(num);
  int i = 0;
  if (int_part < 0) {
    str[i++] = '-';
    int_part = -int_part;
  }
  do {
    str[i++] = int_part % 10 + '0';
    int_part /= 10;
  } while (int_part > 0);

  if (str[0] == '-') {
    reverse_str(str + 1, i - 1);
  }
  else {
    reverse_str(str, i);
  }

  return i;
}

int hex_to_str(int num, char *str) {
  int i = 0;
  int rem;
  while ( num != 0){
    rem = num % 16;
    if( rem < 10 )
      str[i] = rem + 48;
    else
      str[i] = rem + 55;
    i++;
    num /= 16;
  }
  reverse_str(str, i);
  return i;
}

int float_to_str(double num, int precision, char *str) {
  int int_part = (int) num;            // get the integer part of the number
  int prec_count = 0;                  // precision count
  double frac_part = num - int_part;   // get the fractional part of the number
  int i = 0;
  
  /* convert the integer part to a string */
  if (int_part == 0) {
    str[i++] = '0';
  }
  else {
    if (int_part < 0) {
      str[i++] = '-';
      int_part = -int_part;
    }
    do {
      str[i++] = int_part % 10 + '0';
      int_part /= 10;
    } while (int_part > 0);
    if (str[0] == '-') {
      reverse_str(str + 1, i - 1);
    }
    else {
      reverse_str(str, i);
    }
  }
  
  /* add the decimal point and convert the fractional part to a string */
  if (frac_part != 0.0) {
    str[i++] = '.';
    do {
      frac_part *= 10;
      int digit = (int) frac_part;
      str[i++] = digit + '0';
      frac_part -= digit;
      prec_count++;
    } while (frac_part != 0.0 && prec_count<precision && i<20);
  }
  return i;
}

int revvsnprintf(char *str, size_t size, const char *format, va_list args) {
    int i, len, written = 0, precision = 2;
    char *out = str;

    /* Iterate through the format string */
    for (i = 0; format[i] && written < size - 1; i++) {
        /* If the current character is not a format specifier, copy it to the output */
        if (format[i] != '%') {
            *out++ = format[i];
            written++;
            continue;
        }
        i++;

        /* Get the precision number */
        if (format[i] == '.'){
          precision = 0;
          i++;
          while (format[i] >= '0' && format[i] <= '9') {
            precision = precision * 10 + format[i] - '0';
            i++;
          }
        }

        /* Handle the format specifier */
        switch (format[i]) {
            case 's': {
              char *arg = va_arg(args, char *);
              while (*arg && written < size - 1) {
                *out++ = *arg++;
                written++;
              }
              break;
            }
            case 'd': {
              int arg = va_arg(args, int);
              char buf[20];
              int num_digits = int_to_str(arg, buf);
              for( int j=0; j<num_digits && written < size -1; j++ ){
                *out++ = buf[j];
                written++;
              }
              break;
            }
            case 'x':{
              int arg = va_arg(args, int);
              char buf[20];
              int num_digits = hex_to_str(arg, buf);
              for( int j=0; j<num_digits && written < size -1; j++ ){
                *out++ = buf[j];
                written++;
              }
              break;
            }
            case 'f': {
              double arg = va_arg(args, double);
              char buf[20];
              int num_digits = float_to_str(arg, precision, buf);
              for( int j=0; j<num_digits && written < size -1; j++ ){
                *out++ = buf[j];
                written++;
              }
              break;
            }
            case 'c': {
              char arg = va_arg(args, int);
              *out++ = arg;
              written++;
              break;
            }
            /* Add more cases for other format specifiers as needed */
            default:
              *out++ = format[i];
              written++;
              break;
        }
    }

    /* Null-terminate the output string */
    *out = '\0';

    /* Return the number of characters written (not counting the null terminator) */
    return written;
}

extern void revprintf( const char *format, ...){
  // Parse the formatted string and save it in the xbgas output buffer.
  va_list args;
  int length;
  va_start(args, format);
  /* The vsnprintf in the standard library cannot work correctly, so we implemented our customized version, revvsnprintf. */
  // length = vsnprintf((char*)(_XBGAS_OUTPUT_BUFFER_START_), _XBGAS_OUTPUT_BUFFER_SIZE_, format, args);
  length = revvsnprintf((char*)(_XBGAS_OUTPUT_BUFFER_START_), _XBGAS_OUTPUT_BUFFER_SIZE_, format, args);
  va_end(args);
  
  *((uint64_t*)(_XBGAS_OUTPUT_BUFFER_LENGTH_)) = (uint64_t)(length);
}



/* EOF */