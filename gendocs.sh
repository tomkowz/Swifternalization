rm -rf docs

jazzy -o docs/framework --podspec Swifternalization.podspec --min-acl private -m "Swifternalization"
jazzy -o docs/public --podspec Swifternalization.podspec --min-acl public -m "Swifternalization Public API"

rm -rf build