rm -rf docs

jazzy -o docs/framework -a 'Tomasz Szulc' -u 'http://szulctomasz.com' -g 'http://github.com/tomkowz/Swifternalization' --min-acl private

jazzy -o docs/public -a 'Tomasz Szulc' -u 'http://szulctomasz.com' -g 'http://github.com/tomkowz/Swifternalization' --min-acl public

rm -rf build