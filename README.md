<h1 align="center"> Virtual Pet </h1>

# Index

- [Description](#Description)
- [Planning](#Planning)
- [Technologies](#Technologies)
- [Branch Structure](#BranchStructure)
- [Commit Pattern](#CommitPattern)


## Description
- Team: Elsner, Maria, Nat, Sofia e Vitória
- Challenge: Creating an engaging virtual pet.

## Planning
Detalhado dentro do Airtable do projeto

## Technologies
Swift, SwiftUI, CoreData, WatchKit

## Branch Structure
The main repository will always hold two evergreen branches: main and development. 

- Main: will contain the latest code deployed to production

- Development: where the source code of `HEAD` always reflects a state with the latest delivered development changes for the next release

Supporting branches will be used to aid parallel development. These supporting branches must branch from development and merge back into development.

Branch naming convention: `<USNumber>/<TKNumber>-<description>`

Example: `$ git checkout -m US011/TK011-add-favorites-list`

## Commit Pattern
Applying the standards defined by commit message formatting. The commit message should be structured as follows: `<type>: <description>`

Types are: feat, fix, refactor, test.

Example:
`$ git commit -m "feat: add tabbar to application`
