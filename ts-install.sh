#!/bin/sh
alias yarn='docker run -it --rm -v $(pwd):/usr/src/task/ -v /root:/root -w /usr/src/task node-lts'
yarn set version berry
yarn add --dev typescript eslint prettier stylelint
yarn plugin import typescript
yarn plugin import interactive-tools

yarn dlx @yarnpkg/sdks vscode
yarn add @types/node@~16 -D

mkdir src
mkdir lib
touch src/index.js

cat <<\EOF > "tsconfig.json"
{
  "compilerOptions": {
    "module": "commonjs",
    "esModuleInterop": true,
    "target": "es6",
    "moduleResolution": "node",
    "sourceMap": true,
    "outDir": "lib",
    "rootDir": "src"
  },
  "lib": ["es2020"],
  "include": ["src"]
}
EOF

cat <<\EOF >> ".gitignore"
.yarn/*
!.yarn/patches
!.yarn/plugins
!.yarn/releases
!.yarn/sdks
!.yarn/versions

# Swap the comments on the following lines if you don't wish to use zero-installs
# Documentation here: https://yarnpkg.com/features/zero-installs
# !.yarn/cache
.pnp.*
EOF

cat <<\EOF >> ".editorconfig"
root = true

[*]
end_of_line = lf
insert_final_newline = true

[*.{js,json,yml}]
charset = utf-8
indent_style = space
indent_size = 2
root = true

[*]
end_of_line = lf
insert_final_newline = true

[*.{js,json,yml}]
charset = utf-8
indent_style = space
indent_size = 2
EOF

