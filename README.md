# ZSSN (Zombie Survival Social Network)

This project follows the rules and terms from Codeminer42 backend test.

## Project Setup and answering some Questions:

### How is the project proccess?
  * It isn't finished yet, but everything it already haves its described bellow:

### How to run the project?   
* First you needto have docker and docker-compose commands installed in your machine   
After that, there are some commands you need to run before running project:   
``docker-compose build``   
``docker-compoe up -d``   
``docker-compose exec web bundle install``   
``docker-compose exec web rails db:create``   
``docker-compose exec web rails db:migrate``  

### How can I run the tests?    
``docker-compose exec web rspec``   

### How can I see Simplecode's code coverage report?
open at browser the file at ./coderage/index.html   
     
### How can I see project running?
Unfortunently the project is not consumable yet. It only have the tests suite passing    
    
### But, how can I see, what you did in this project?   
Weel, I will try to explain what was did and what was I was thinking in doing that this like that

## The project:
* First, everything I made is in domain layer. After that I would need to implement at service layer to, in order to take requests and calls domain object rules to apply those features:   
### Add survivors to the database:
* I can save survivors on database with the Survivor model. 
* I already made its persistance validation too. It is on SurvivorValidator which is a Concern extracting every validation to survivo's model persistance
 
### A survivor also must have an inventory:
* Survivor have an inventory of items, and can access them directly by has through association or by inventory and after items

### Survivors cannot Add/Remove items from inventory    
* I followed the CQRS principle: separating command (update and delete) from queries (to ease, I didn't make it readonly, I used before update callback to avoid it to be updated)    
* Survivors have access to the QueryInventory class, witch have access only in be created and list, filter and search items on inventory. At this way a survivor cannot change it inventory directly.   
   
### A survivor is marked as infected when at least three other survivors report their contamination.
* I used a state machine to manage survivor contamination reports, which, calling the same method, I could change its state.
* I used AASM gem to help with this feature  
* After the third report, there is called a callback that **flags survivor as infected**

### When a survivor is infected, his/her inventory items become inaccessible (they cannot trade with others).
* In order to resolve this, I made an Observer, which looks for survivor's infection and where it happens, it goes and change its inventory items state to infected too, with this, they became losed.

## [FUTURE THINGS]Trading items - A layered system worflow
* I'm already doing this feature, 'Cause this I'll only tell how is my work in planning:




