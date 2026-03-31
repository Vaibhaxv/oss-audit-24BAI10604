#!/bin/bash
# ============================================================
#  Script 5: Interactive Open Source Quiz
#  Course: Open Source Software — Python Audit
#  Description: Asks the user 3 questions about open source
#               software and saves their answers to a file.
# ============================================================

echo "=============================================="
echo "      OPEN SOURCE INTERACTIVE QUIZ           "
echo "=============================================="
echo ""
echo "  Welcome! Please answer the 3 questions below."
echo "  Your responses will be saved to a text file."
echo ""
echo "----------------------------------------------"
echo ""

# --- Output file setup ---
OUTPUT_DIR="$(pwd)"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
OUTPUT_FILE="$OUTPUT_DIR/open_source_answers_$TIMESTAMP.txt"

# --- Collect user's name ---
echo -n "  First, what is your name? : "
read -r USER_NAME

if [ -z "$USER_NAME" ]; then
    USER_NAME="Anonymous"
fi

echo ""
echo "  Hello, $USER_NAME! Let's begin."
echo ""
echo "=============================================="
echo ""

# ---- QUESTION 1 ----
echo "  QUESTION 1:"
echo "  What do you understand by the term 'Open Source Software'?"
echo "  (Type your answer and press Enter)"
echo ""
echo -n "  Your Answer: "
read -r ANSWER_1
echo ""

# ---- QUESTION 2 ----
echo "  QUESTION 2:"
echo "  Name ONE popular open-source project and explain why it is important"
echo "  to the developer community."
echo "  (Type your answer and press Enter)"
echo ""
echo -n "  Your Answer: "
read -r ANSWER_2
echo ""

# ---- QUESTION 3 ----
echo "  QUESTION 3:"
echo "  What is the difference between 'free software' (as defined by"
echo "  the FSF) and 'open-source software' (as defined by the OSI)?"
echo "  (Type your answer and press Enter)"
echo ""
echo -n "  Your Answer: "
read -r ANSWER_3
echo ""

echo "----------------------------------------------"
echo "  [*] Saving your responses..."
echo ""

# --- Write answers to file ---
cat > "$OUTPUT_FILE" << EOF
==============================================
   OPEN SOURCE SOFTWARE — QUIZ RESPONSES
==============================================

Respondent Name : $USER_NAME
Date & Time     : $(date "+%A, %d %B %Y at %I:%M %p")
Saved To        : $OUTPUT_FILE

==============================================

QUESTION 1:
What do you understand by the term 'Open Source Software'?

ANSWER:
$ANSWER_1

----------------------------------------------

QUESTION 2:
Name ONE popular open-source project and explain why it is important
to the developer community.

ANSWER:
$ANSWER_2

----------------------------------------------

QUESTION 3:
What is the difference between 'free software' (as defined by the FSF)
and 'open-source software' (as defined by the OSI)?

ANSWER:
$ANSWER_3

==============================================
             END OF RESPONSES
==============================================
EOF

# --- Confirm save ---
if [ -f "$OUTPUT_FILE" ]; then
    echo "  [+] Responses saved successfully!"
    echo ""
    echo "  File Location : $OUTPUT_FILE"
    echo "  File Size     : $(du -sh "$OUTPUT_FILE" | awk '{print $1}')"
    echo ""
    echo "----------------------------------------------"
    echo ""
    echo "  Here is a preview of your saved responses:"
    echo ""
    cat "$OUTPUT_FILE"
else
    echo "  [-] ERROR: Could not save responses to file."
    echo "  Please check write permissions for: $OUTPUT_DIR"
fi

echo ""
echo "=============================================="
echo "          THANK YOU, $USER_NAME!             "
echo "    END OF OPEN SOURCE INTERACTIVE QUIZ      "
echo "=============================================="
