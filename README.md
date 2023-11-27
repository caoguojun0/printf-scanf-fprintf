## How it works 

This code is written in assembly language for the x86 architecture and is a simple programme to output formatted strings in the style of the printf/scanf family of functions from C. It uses Linux system calls to output data. It uses Linux system calls to output data.

The description below will fit almost all files, only if the scanf functions are run, it will read from the console

- Data: The .data section defines the strings that will be used for output. format_string is a format string similar to the one used in printf. The remaining strings and characters represent the data that will be inserted into the format string.

- _start: This is the entry point to the programme. Here, the strings and characters to be inserted are placed on the stack in reverse order. The format_string address is then loaded into the edi register.

- print: This is the function that processes the format string and outputs the corresponding strings and characters.

- start_print: This block checks each character in the format string. If it detects the % character, it goes to the check_format block to process the format specifier.

- check_format: This block checks the next character after % to determine the format type (%s for strings and %c for characters).

- print_smth: This block prints the string or character that matches the format specifier.

- print_loop: This block outputs each character of the string until it reaches the null terminator.

- end_ret: Ends the programme.

To change a formatted string or inserted data, simply change the appropriate lines in the .data section. For example, to change the name, replace "Alex" with the desired name. If you add more format specifiers to format_string, make sure you also add the appropriate data to the stack in the _start function in the correct order.