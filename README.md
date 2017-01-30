# gitpull scripting
## Automating git pull using bash scripting

It's a simple bash script to automate pulls on servers

## :wrench: Usage


:rocket: **First time**

Before run the first time, you need to configure some parameters in the script file:

`Mail_To, Mail_From, Mail_Subject, Git_Repo, Branch, Local_Dir`

Then, configure, run the script using:
```sh
$ ./autogitpull.sh
```

:unicorn: **Instalation**

After execute the script manually without errors you can schedule the script using the following command:

```sh
$ crontab -e
```

Adding the next line (replace the script path!):

`* * * * * /home/axelvf/gitpull/autogitpull.sh >/dev/null 2>&1`

## :blue_heart: Contributing

Pull requests and stars are always welcome. For bugs and feature requests, [please create an issue](https://github.com/axelvf/gitpull/issues)

## :space_invader: Author

**Axel Vasquez**

* [twitter/axelvf](https://twitter.com/axelvf)
* [linkedin/axelvasquez](https://linkedin.com/in/axelvasquez)


## :black_nib: License

Copyright © 2017 [Axel Vasquez](https://github.com/axelvf)
Licensed under the MIT license.

***

_This readme was based on [readme-generator](https://github.com/jonschlinkert/readme-generator) template._
