#!/bin/bash

# Start Xvfb
Xvfb :99 &
export DISPLAY=:99

# Directory containing all the project directories
BASE_DIR="."

# Output base directory
OUTPUT_BASE_DIR="public"

function log_debug() {
    if [ "$DEBUG" = true ]; then
        echo "[DEBUG] $1"
    fi
}

function log_error() {
    echo "[ERROR] $1"
}

# Function to generate HTML report for a given .archimate file
generate_report() {
    local model_file="$1"
    local base_name
    base_name=$(basename "$model_file" .archimate)
    local output_dir="$OUTPUT_BASE_DIR/$base_name"

    # Create the output directory if it doesn't exist
    mkdir -p "$output_dir" || {
        log_error "Failed to create output directory: $output_dir"
        exit 1
    }
    log_debug "Output directory: $output_dir created or already exists"

    # Generate the HTML report
    log_debug "Generating HTML report for $model_file"
    /opt/Archi/Archi -consoleLog -console -nosplash -application com.archimatetool.commandline.app --loadModel "$model_file" --html.createReport "$output_dir" >"$output_dir/report.log" 2>&1

    # Check if the report was generated successfully
    if [ $? -eq 0 ]; then
        # Add link to the index file
        echo "<li><a href=\"${dir_name}_${base_name}/index.html\">${dir_name}_${base_name}</a></li>" >> "$INDEX_FILE"
        log_debug "Added link to index: ${dir_name}_${base_name}/index.html"
        echo "Generated report for ${dir_name}_${base_name} in $output_dir"
    else
        log_error "Error generating report for $model_file. Check $output_dir/report.log for details."
    fi
}

# Check if the output base directory exists, if not create it
if [ ! -d "$OUTPUT_BASE_DIR" ]; then
    mkdir -p "$OUTPUT_BASE_DIR" || {
        log_error "Failed to create directory: $OUTPUT_BASE_DIR"
        exit 1
    }
    log_debug "Created directory: $OUTPUT_BASE_DIR"
else
    log_debug "$OUTPUT_BASE_DIR already exists."
fi

# Initialize the index.html file
INDEX_FILE="$OUTPUT_BASE_DIR/index.html"
{ 
    echo "<html><head><title>Reports</title>"
    echo '<style>
    body { font-family: Arial, sans-serif; margin: 20px; }
    h2 { color: #333; }
    ul { list-style-type: none; padding: 0; }
    li { margin-bottom: 10px; }
    a { text-decoration: none; color: #1a73e8; }
    a:hover { text-decoration: underline; }
    .container { max-width: 600px; margin: left; }
    </style>'
    echo "</head><body>"
    echo '<div class="container">'
    echo "<h2>List of reports</h2><ul>"
} > "$INDEX_FILE"
log_debug "Initialized $INDEX_FILE"

# Find all .archimate files and process them
IFS=$'\n'  # Set Internal Field Separator to newline to handle spaces in filenames correctly
archimates=$(find "$BASE_DIR" -type f -name "*.archimate" || true)

if [ -z "$archimates" ]; then
    log_debug "No .archimate files found."
else
    for model_file in $archimates; do
        # Check if the file exists and is a regular file
        if [ -f "$model_file" ]; then
            log_debug "Processing file: $model_file"
            generate_report "$model_file"
        else
            log_debug "Skipping invalid file: $model_file"
        fi
    done
fi

# Close the HTML tags in the index file
echo '</ul></div></body></html>' >> "$INDEX_FILE"
log_debug "Completed index file $INDEX_FILE"
