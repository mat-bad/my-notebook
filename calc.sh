#!/bin/bash

# ============================================
# CALC.SH - Advanced Calculator Script
# Supports both interactive and argument modes
# ============================================

# Function: Argument Mode
# Usage: Called when script receives command-line arguments
argument_mode() {
    # Check for exactly 3 arguments
    if [ $# -ne 3 ]; then
        echo "Error: Invalid number of arguments" >&2
        echo "Usage: $0 num1 operator num2" >&2
        echo "Example: $0 1920 \* 1080" >&2
        exit 1
    fi
    
    num1="$1"
    operator="$2"
    num2="$3"
    
    # Validate first operand is numeric
    if ! [[ $num1 =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
        echo "Error: '$num1' is not a valid number" >&2
        exit 1
    fi
    
    # Validate second operand is numeric
    if ! [[ $num2 =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
        echo "Error: '$num2' is not a valid number" >&2
        exit 1
    fi
    
    # Validate operator and perform calculation
    case $operator in
        +)
            result=$(echo "$num1 + $num2" | bc)
            ;;
        -)
            result=$(echo "$num1 - $num2" | bc)
            ;;
        \*)
            result=$(echo "$num1 * $num2" | bc)
            ;;
        /)
            # Check for division by zero
            if [ "$(echo "$num2 == 0" | bc)" -eq 1 ]; then
                echo "Error: Division by zero is not allowed" >&2
                exit 1
            fi
            result=$(echo "scale=2; $num1 / $num2" | bc)
            ;;
        *)
            echo "Error: Invalid operator '$operator'" >&2
            echo "Valid operators: +  -  *  /" >&2
            exit 1
            ;;
    esac
    
    # Output result to stdout
    echo "$result"
}

# Function: Interactive Mode
# Usage: Called when script runs without arguments
interactive_mode() {
    # Get username
    username=$(whoami)
    
    # Welcome message
    echo "============================================"
    echo "Welcome $username!"
    echo "============================================"
    
    # Display instructions
    echo "📖 CALCULATOR INSTRUCTIONS:"
    echo "   • Enter calculations in the format: number operator number"
    echo "   • Example: 5 + 3"
    echo "   • Valid operators: +  -  *  /"
    echo "   • Type 'bye' to exit"
    echo "============================================"
    echo ""
    
    # Main interaction loop
    while true; do
        # Get input from user
        echo -n "calc> "
        read input
        
        # Check for exit condition
        if [ "$input" = "bye" ] || [ "$input" = "exit" ] || [ "$input" = "quit" ]; then
            echo ""
            echo "============================================"
            echo "👋 Goodbye $username! Thanks for using calc.sh"
            echo "============================================"
            break
        fi
        
        # Split input into three parts using awk (handles extra spaces)
        num1=$(echo "$input" | awk '{print $1}')
        operator=$(echo "$input" | awk '{print $2}')
        num2=$(echo "$input" | awk '{print $3}')
        extra=$(echo "$input" | awk '{print $4}')
        
        # Check if user entered exactly 3 tokens
        if [ -z "$num1" ] || [ -z "$operator" ] || [ -z "$num2" ]; then
            echo "❌ Error: Please enter exactly: number operator number" >&2
            echo "   Example: 10 + 5" >&2
            continue
        fi
        
        # Check for extra arguments
        if [ -n "$extra" ]; then
            echo "❌ Error: Too many arguments. Please enter: number operator number" >&2
            continue
        fi
        
        # Validate first operand is numeric
        if ! [[ $num1 =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
            echo "❌ Error: '$num1' is not a valid number" >&2
            echo "   Please enter a numeric value" >&2
            continue
        fi
        
        # Validate second operand is numeric
        if ! [[ $num2 =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
            echo "❌ Error: '$num2' is not a valid number" >&2
            echo "   Please enter a numeric value" >&2
            continue
        fi
        
        # Validate operator and perform calculation
        case $operator in
            +)
                result=$(echo "$num1 + $num2" | bc)
                echo "✅ $num1 + $num2 = $result"
                ;;
            -)
                result=$(echo "$num1 - $num2" | bc)
                echo "✅ $num1 - $num2 = $result"
                ;;
            \*)
                result=$(echo "$num1 * $num2" | bc)
                echo "✅ $num1 × $num2 = $result"
                ;;
            /)
                # Check for division by zero
                if [ "$(echo "$num2 == 0" | bc)" -eq 1 ]; then
                    echo "❌ Error: Division by zero is not allowed" >&2
                    continue
                fi
                result=$(echo "scale=2; $num1 / $num2" | bc)
                echo "✅ $num1 ÷ $num2 = $result"
                ;;
            *)
                echo "❌ Error: Invalid operator '$operator'" >&2
                echo "   Valid operators: +  -  *  /" >&2
                continue
                ;;
        esac
        echo ""
    done
}

# ============================================
# MAIN SCRIPT EXECUTION
# ============================================

# Check if arguments are provided
if [ $# -eq 0 ]; then
    # No arguments - run interactive mode
    interactive_mode
else
    # Arguments provided - run argument mode
    argument_mode "$@"
fi

exit 0
