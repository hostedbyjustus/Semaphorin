TARGET_CODESIGN = $(shell command -v ldid)

P1TMP          = $(TMPDIR)/semaphorin
P1_REQUIRED    = Required
P1_STAGE_DIR   = $(P1TMP)/stage
P1_APP_DIR        = $(P1TMP)/Build/Products/Release/semaphorin.app

.PHONY: package

package:
	@rm -rf $(P1_REQUIRED)/*.deb

	@git clone --recursive https://github.com/y08wilm/Semaphorin

	@tar -czvf semaphorin.tar.gz ./Semaphorin/*

	@mv semaphorin.tar.gz Required/

	@rm -rf Semaphorin

	@set -o pipefail; xcodebuild -jobs $(shell sysctl -n hw.ncpu) -project 'semaphorin.xcodeproj' -scheme semaphorin -configuration Release -arch x86_64 -derivedDataPath $(P1TMP) CODE_SIGNING_ALLOWED=NO DSTROOT=$(P1TMP)/install ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES=NO

	@ls $(P1TMP)/Build/Products/

	@rm -rf Payload
	@rm -rf $(P1_STAGE_DIR)/
	@mkdir -p $(P1_STAGE_DIR)/Payload
	@mv $(P1_APP_DIR) $(P1_STAGE_DIR)/Payload/semaphorin.app

	@echo $(P1TMP)
	@echo $(P1_STAGE_DIR)

	@$(TARGET_CODESIGN) -Sentitlements.plist $(P1_STAGE_DIR)/Payload/semaphorin.app/

	@rm -rf $(P1_STAGE_DIR)/Payload/semaphorin.app/_CodeSignature

	@ln -sf $(P1_STAGE_DIR)/Payload Payload

	@rm -rf packages
	@mkdir -p packages

	@cp -r $(P1_REQUIRED)/* $(P1_STAGE_DIR)/Payload/semaphorin.app/Contents/Resources

	@codesign --remove-signature $(P1_STAGE_DIR)/Payload/semaphorin.app
	
	@hdiutil create -fs HFS+ -srcfolder "$(P1_STAGE_DIR)/Payload/" -volname "semaphorin" "semaphorin.dmg"

	@rm -rf Payload
