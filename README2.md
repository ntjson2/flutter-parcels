# ADV Calendar

## Complete Features

> Project 5

- Finish prepping the database connection to firebase - Finished
-- Related commmits

--- [Fixed start state and profile start bugs #26]


## Helpful steps

    - 1. Make a new directory: finalproject (name does not matter)
    
    - 2. Open VS code in that directory, open a new terminal window in VS code, and clone the git 

    - 3. repository (don't forget the period at the end to avoid creating an extra directory)

## More

    - Make new directory: finalproject (name does not matter)

    - Open VS code in that dir, open new terminal window in VS code and clone the git dir (don't forget period at the end to avoid creating an extra directory)

         git clone https://github.com/ntjson2/victors-calendar.git .

    - If you don't have ionic cli, run the command below

         $npm i -g @ionic/cli

    - check to see if it is working so far

        cd .\victors-calendar\

        ionic serve

        Install vite? Yes

### This should fire up a localhost instance and show the web page, make sure to install firebase

        npm install firebase
        npm install -g firebase-tools

## Misc

### Adding new files

        git add -A

### commit

        git commit -m "2nd commit"

    ### push to development
        git push -u origin development

### Deleting remote branches

        git push origin --delete myoldbranch

### pulling from development branch

        git pull origin development

### checkout local development branch

         git checkout -b development

## ENV file

    - Place the .env file outside of the src folder. Do this for .env.local as well if using this file

## More GIT help

     ## Start a new feature

         git checkout -b new-feature main

     ## Edit some files

         git add myfile

         git commit -m "Start a feature"

     ## Edit some files then add

         git add myfile

         git commit -m "Finish a feature"

     ## Develop the main branch

         git checkout main

     ## Edit some files again

         git add myfile

         git commit -m "Make some super-stable changes to main"

     ## Merge in the new-feature branch then delete it

         git merge new-feature

         git branch -d new-feature

    ## Deleting remote branch

        git push origin --delete new-feature 