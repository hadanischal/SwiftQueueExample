#!/bin/sh

# Define output file. Change "$PROJECT_DIR/Tests" to your test's root source folder, if it's not the default name.
PROJECT_DIR="."
PROJECT_NAME="SwiftQueueExample"
PROJECT_NAME_TESTS="SwiftQueueExampleTests"
PODS_ROOT="$PROJECT_DIR/Pods"
OUTPUT_FILE="$PROJECT_DIR/${PROJECT_NAME_TESTS}/GeneratedMocks.swift"
echo "Generated Mocks File = $OUTPUT_FILE"

# Define input directory. Change "$PROJECT_DIR" to your project's root source folder, if it's not the default name.
INPUT_DIR="$PROJECT_DIR/${PROJECT_NAME}"
echo "Mocks Input Directory = $INPUT_DIR"

# Generate mock files, include as many input files as you'd like to create mocks for.
${PODS_ROOT}/Cuckoo/run generate --testable "${PROJECT_NAME}" \
--output "${OUTPUT_FILE}" \
"$INPUT_DIR/Service/WebService/WebServiceProtocol.swift" \
"$INPUT_DIR/Service/WebService/WebService.swift" \
"$INPUT_DIR/Service/ApiHandler/BaseApiHandlerProtocol.swift" \
"$INPUT_DIR/Service/ApiHandler/BaseApiHandler.swift" \
"$INPUT_DIR/ViewModel/BaseViewModelProtocol.swift" \
"$INPUT_DIR/ViewModel/BaseViewModel.swift" \
"$INPUT_DIR/ViewModel/SelectPhotoViewModel.swift" \
"$INPUT_DIR/ViewModel/SelectPhotoViewModelProtocol.swift" \
"$INPUT_DIR/ImageManager/ImageManagerProtocol.swift" \
"$INPUT_DIR/ImageManager/ImageManager.swift" \
"$INPUT_DIR/SwiftQueueHandler/QueueManager/QueueManagerProtocol.swift" \
"$INPUT_DIR/SwiftQueueHandler/JobScheduler/JobHandler.swift" \
"$INPUT_DIR/SwiftQueueHandler/JobHandler/JobProtocol.swift"
# ... and so forth
