---
title: Git submodule to use Hugo theme on githubPage
author: Frank
date: '2020-03-14'
categories:
  - Git
  - Website theme
tags:
  - tricks
slug: git-submodule-to-have-the-best-from-both-githubpage-and-hugo-theme
emoji: yes
output:
  blogdown::html_page:
    toc: yes
---


# Driver

Originally, I was keen to just use the githubPage approach to do this documentation blog because it feels easy. Then, the Yihui's book _Blogdown_ introduces this amazing **HUGO** themes. I became greed and want to have the best of both worlds although I realised that githubPage is not the number one recommendation for deploying the website when half way through the book. However, the stubbornness kicked in and the desire of using githubPage with HUGO themes got the vote. Initially, [Yihui's suggestion](https://bookdown.org/yihui/blogdown/github-pages.html) had been followed. But soon the problem of version control the nested git repository became very tricky. The [documentation](https://gohugo.io/hosting-and-deployment/hosting-on-github/) on the Hugo website come in to rescue. 

# The idea

The idea is to use a nested repository structure to have multiple `submodule(s)` in one parent repository. It is easier to download whatever the themes we might like in the future from the [HUGO](https://themes.gohugo.io/) without being limited by the githubPage themes. There are many [tutorials](https://chrisjean.com/git-submodules-adding-using-removing-and-updating/) and [examples](https://git-scm.com/book/en/v2/Git-Tools-Submodules) that using `submodule(s)` to manage website projects. Here is another record to the list. :laughing:

# Ingredients 

## Software and Libraries

| | |
|:---|:----|
|git | 2.16.2.windows.1|
|R version | 3.6.2 |
|Rstudio |1.2.1335|
|Rmarkdown |2.1|
|blogdown |0.18|
|knitr |1.27|

## Github repositories 

Two repositories will be needed for this post.One for having the project content - where we hold the materials for posts and themes. The other one to host all the public materials that have been rendered and ready to display on the website. 

For example, the repo [ApsimXLearn](https://github.com/frank0434/ApsimXLearn) contains all the themes and raw `.Rmd` files to build the posts. 

The repo [frank0434.github.io](https://github.com/frank0434/frank0434.github.io) has only the rendered materials to show on the [website](https://frank0434.github.io/). 

# Step by Step receipt

It is necessary to have a go on Yihui's [book](https://bookdown.org/yihui/blogdown/) first. The book explains the idea of how blogdown package works and other very useful tips and tricks when trying to develop your own websites or blogs.

Once the installation part sorted. One can either start a new site by `blogdown::new_site()` or the [UI option](https://bookdown.org/yihui/blogdown/rstudio-ide.html) in Rstudio. A new site has a minimal folder structure as following:  

```
├───content
│   └───post
├───resources
│   └───_gen
│       ├───assets
│       └───images
├───static
└───themes
    └───hugo-lithium
        ├───archetypes
        ├───exampleSite
        │   ├───content
        │   │   └───post
        │   └───static
        ├───layouts
        │   ├───partials
        │   └───_default
        └───static
            ├───css
            ├───fonts
            ├───images
            └───js
```
The key folders/directories are content, resources, static and themes. You would notice that `public` is missing if you have been through [Yihui's book](https://bookdown.org/yihui/blogdown/rstudio-ide.html). No `public` directory is a good start. Now, we can start the infrastructure.   

  1. we can add a `.Rproj` to put this new site into a R project.   
  2. Use the function `use_git` from the `usethis` R package to initial the git repo.     
  3. First commit will be made to the local repo once we finish the interactive process in `use_git`.  
  4. Go to the personal github account and create a new repo for hosing the GithubPage website. Github has [a detailed tutorial](https://help.github.com/en/github/working-with-github-pages/creating-a-github-pages-site) to do this.  
  5. Copy the url once the repo has been created on Github.  
  6. Shortcut key `Alt + Shift + T` to jump to the `Terminal console` in Rstudio.   
  7. Use command `git submodule add https://github.com/******/*******.github.io.git public`. This is to add the hosting repo as a submodule to the parent repo. The command here also triggers the `cloning` which will download the materials if there is any.    
  8. `git submodule` can verify if the submodule has been added successfully. All good if the console shows something like   
  ```
  $ git submodule
   08d8c2cb943b395d9d3658dd45d5ef03409edc84 public (heads/master)
  ```  
  9. Now we can go to create new post or edit existing ones or customise the theme by using blogdown addins in Rstudio. Further details can be found in [the book](https://bookdown.org/yihui/blogdown/rstudio-ide.html).   
  10. Every time when `blogdown::serve_site()` is triggered, the content in `public` directory will be updated. The stuff in the `public` directory is meant to be push back to the repo that created in step 4.  
  11. Use a `shell` script to help the push back process is suggested by the [HUGO documentation](https://gohugo.io/hosting-and-deployment/hosting-on-github/). A modified version below is used in this case since we are using `blogdown` to build the website. The script here assume that we are happy to just use the date and time as commit message. 
  ```
  #!/bin/sh
  
  # Go To Public folder
  cd public
  
  # Add changes to git.
  git add .

  git commit -m "$msg"
  
  # Push source and build repos.
  git push origin master  
  ```
  12. Save the script in step 11 to the parent directory and named it as `deploy.sh`. Remember to call `chmod` to change the `deploy.sh` executable before call it like a normal command. 
  
  **Optional steps to have parent repo pushed to github**  
  
  13. Our parent repo is still in the local environment. I found the `usethis::use_github()` is very easy to use for pushing local repo to github, although it requires a tiny bit configuration before we can use. Again, this is just personal preference. One can always add a remote to the local repo and push it via command line.   
  14. A similar `*.sh` script can be used for pushing commits in parent repo as well.  
  15. Now we have the parent repo and website children repo version controlled locally and backed up on github. We can do wherever and whenever to update and modify the content of the blog. :grin:
  
  
The current structure of this blog shows below: 

```
├───.Rproj.user
|\\\\\IGNORE IRRLAVENT DIRS\\\\\
├───content
│   └───post
├───public
│   ├───2020
│   │   └───03
│   │       ├───10
│   │       │   └───apism-next-generation-custom-build-101
│   │       ├───13
│   │       │   └───multiply-apsimx-files-via-models-exe
│   │       ├───14
│   │       │   └───git-submodule-to-have-the-best-from-both-githubpage-and-hugo-theme
│   ├───about
│   ├───categories
│   │   ├───apsimx
│   │   ├───build
│   │   └───draft
│   ├───css
│   ├───fonts
│   ├───frank0434.github.io
│   ├───images
│   ├───js
│   ├───post
│   │   ├───2020-03-10-apism-next-generation-custom-build-101_files
│   │   └───2020-03-13-multiply-apsimx-files-via-models-exe_files
│   ├───rmarkdown-libs
│   │   ├───elevate-section-attrs
│   │   └───jquery
├───static
│   ├───post
│   │   └───2020-03-13-multiply-apsimx-files-via-models-exe_files
│   └───rmarkdown-libs
│       ├───elevate-section-attrs
│       └───jquery
└───themes
    └───hugo-lithium
        ├───archetypes
        ├───exampleSite
        │   ├───content
        │   │   └───post
        │   └───static
        ├───layouts
        │   ├───partials
        │   └───_default
        └───static
            ├───css
            ├───fonts
            ├───images
            └───js
  
```
# Collaborating with others 

It seems to be not straight forward when it comes to collaboration. 

The `public` directory is already in the `git` index although it is empty when we pull down the `ApsimXLearn` repository to a new machine. This is problematic because we could not add the submodule nor update it. 

One way to work around is to remove the empty `public` directory first and clean the `git cached` as well. Then add the `github.io` repository to the submodule. 

A step by step will be:   

1. Clone the `ApsimXLearn` repository down to local.   
```
$ git clone https://github.com/frank0434/ApsimXLearn.git
```  

2. Remove the existing and empty `public` directory.  
```
$ cd ApsimXLearn/
$ rm -rf public/
```

3. Remove the git index as well.   
```
$ git rm --cached public
```  

4. Add the `frank0434.github.io` repository as submodule.   
```
$ git submodule add https://github.com/frank0434/frank0434.github.io.git public
```

5. Ready to work on the new post. :smile:


# Next step 

Next step might be to give up the stubbornness and host the blog by [Netlify](https://www.netlify.com/) as recommended?. 



