.PHONY: version clean format lint pubs models rebuild quality

version:
	use 3.3.5

clean: ## Cleans your flutter project's workspace
	flutter clean
	flutter pub get
	dart run build_runner build --delete-conflicting-outputs

format: ## Formats my codebase ## flutter format lib/ test/ --line-length=100
	@echo "Formatting the code..."
	dart fix --apply
	@echo "The code has been formatted"

lint: ## Lints the codebase
	@echo "Analyzing.."
	flutter analyze
	@echo "Analysis completed"

pubs: ## Installs the pubs
	flutter pub get

build_runner: ## Generates files using build runner
	dart run build_runner build --delete-conflicting-outputs

i18n:  ## Generate i18n
	dart plugins/i18n_generator/lib/main.dart --output lib/generated/i18n_lookup.generated.dart

rebuild: pubs i18n models format 

quality: format lint

fix_dry_run:
	dart fix --dry-run

fix_apply:
	dart fix --apply

iphone:
	flutter emulators --launch apple_ios_simulator

android:
	flutter emulators --launch Pixel_3a_API_33_arm64-v8a

all_android:
	flutter emulators --launch Pixel_3a_API_33_arm64-v8a
	flutter emulators --launch Pixel_6_Pro_API_33
	flutter emulators --launch Pixel_6_Pro_API_33_2

xcode:
	open ios/runner.xcworkspace

flutter_launcher_icons:
	flutter pub run flutter_launcher_icons

run_all_dev:
	flutter run -d all --flavor development --target lib/main_dev.dart

app_bundle_dev:
	@echo "Processing..."
	flutter clean
	flutter pub get
	dart run build_runner build --delete-conflicting-outputs
	flutter build appbundle --flavor development --target lib/main_dev.dart
	@echo "DONE 👍"

apk_dev:
	@echo "Processing..."
	flutter clean
	flutter pub get
	dart run build_runner build --delete-conflicting-outputs
	flutter build apk --release --flavor development --target lib/main_dev.dart
	@echo "DONE 👍"


