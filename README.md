### To-do List Recommendations

Grateful for the opportunity to do the case study/ Here is the breakdown of my approach towards the two exercises. Looking forward to discussing it. Kindly note that we will use the `develop` ranch that has changes for both exercises

**Project Setup**

- Ensure you have Elixir 1.14 and Erlang/OTP 25 installed.
- We recommend using [asdf](https://asdf-vm.com/), in which case you can use the `.tool-versions` file in this repository, to setup your development environment.
- Next checkout to the `develop` branch to get the latest updates of the task
- Once your enviroment is prepared, run `mix setup` from the root directory of this repository, to compile the project and initialize the development database.
- Finally start the Phoenix server with `mix phx.server` or inside IEx with `iex -S mix phx.server`.

- Now you can visit [`http://localhost:4000`](http://localhost:4000) from your browser and interact with the application.

**Implementation**

**Exercise 1**

**Managed to do **

1. Used probability based on todo item priority to recommend the next to do
2. Used the principle of the lowest priority number being the most urgent

**Hitches**

1. Got the solution working well for the inverse of the principle (high priority number representing high urgency) :(
2. When trying to tweak the solution I made the algo select the most urgent todo **but** with an 100% probability rate every time, like this:
    
![Screenshot from 2024-08-03 19-47-51](https://github.com/user-attachments/assets/496730ad-908c-4c31-81cb-7c4c1bd8e839)
  -This only means that the chance that `prepare lunch` (highest urgency), will be chosen over and over again is 100%
  - This may be an issue since my solution was to work on probability and not facts lol
  - The upside to this is that it actually fixes Exercise 2 without persistence, yes, a nice-to-have bug maybe? We know that the recommendation will always be the same even on browser restarts because of the 100% probability rate, only until we add a more urgent todo though.

3. I did not write tests for this functionality

**Assumptions**

- My assumptions in all this was that recommended todos should always be the most urgent

**Short Demo**

![improvegif](https://github.com/user-attachments/assets/4c92e960-cac3-40ce-abbf-46becf416e6a)



**Exercise 2**

**Managed to do**

1. Persist current recommended todo using ETS Cache
    - used a dedicated Genserver process to create an ETS table and manage inserts to the cache
    - a new insert to the cache replaces the existent recomendation under the key `next_todo`
    - tested that a recommendation gets persisted through sessions
2. Regenerate a new recommendation and save to the cache at 3 stages:
    - when the current recommended todo is completed
    - when the current recommended todo is deleted
    - And on startup to get the initial recommended todo before any transactions
3. Made Todo titles unique to avoid duplicate todo items(nice-to-have)

**Hitches**
 - None. Had fun.
 - Also had to do a hard-reset since I merged the `improve-recommendations` branch locally, hence the announced `force push`

**Short Demo**

![ami-final](https://github.com/user-attachments/assets/25e45e20-1ac9-4ff8-add7-9d5e632e8baa)

Thats it! Happy coding, or code watching!
