TARGET_DTSO := $(lastword $(MAKECMDGOALS))
TARGET_FILES := $(wildcard $(TARGET_DTSO)*.dtso)
TARGET_FILENAME := $(basename $(TARGET_FILES))

%:
	echo "Processing target $@"
	echo "Compiling files: $(TARGET_FILENAME)"

	@$(foreach file, $(TARGET_FILENAME), \
		echo "Processing file $(file)"; \
		${CC} -undef -x assembler-with-cpp $(file).dtso -I ${KERNEL_INCLUDE} -E -o $(file).dts.preprocessed; \
		${DTC} -@ -O dtb -o $(file).dtbo $(file).dts.preprocessed; \
	)

clean:
	rm -rf *.dtbo
	rm -rf *.preprocessed
