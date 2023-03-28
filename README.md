# Pervitin

![](pervitin.png)

Fast web app prototyping stack tool. Deploy and serve PocketBase backend and Svelte frontend together on localhost.

```sh
chmod +x pervitin.sh
```

This script automates the creation and setup of a Svelte project with an integrated PocketBase backend. It supports two commands: `new` for creating and setting up the project, and `serve` for running both the Svelte development server and the PocketBase server simultaneously. When running the servers with the `serve` command, pressing Ctrl+C will terminate both servers.

```
./pervitin.sh new <project_name>

./pervitin.sh serve <project_name>
```

It works like this so you can manage all your web apps from a parent directory.
