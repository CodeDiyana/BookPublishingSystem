<h1>Book Publishing System</h1>




<h2>Description</h2>
This project outlines the design and creation of a Book publishing system relational database that covers entity-relationship modelling, SQL table creation, business query design, and normalisation. The system handles books, authors, publishers and warehouses and all the relationships are represented in a normalised schema. To illustrate both theoretical knowledge and practice gained on the concept of relational databases.
<br />


<h2>Languages and Utilities Used</h2>

- <b>Database</b> 
- <b>MySql</b>


<h2>Program walk-through:</h2>
:

- <b>Entity–Relationship (ER) modeling</b> 
- <b>SQL table creation (schema design)</b>
- <b>Data population and insertion</b> 
- <b>SQL queries for business insights (e.g., books by author, inventory counts, pricing analysis)</b>
- <b>Constraints and indexing </b> 
- <b>Aggregations using GROUP BY and conditional logic with CASE</b>
- <b>Database normalization practices</b> 




 <b>
Entity–Relationship (ER) modeling <b>
 <b>SQL table creation (schema design) <b>
 <b>Data population and insertion <b>
 <b>SQL queries for business insights (e.g., books by author, inventory counts, pricing analysis) <b>
 <b>Constraints and indexing <b>
 <b>Aggregations using GROUP BY and conditional logic with CASE <b>
 <b>Database normalization practices <b>
 <b>Database</b> 

<h2>Program walk-through:</h2>



<p align="center">
ER Diagram:
The implementation of the type of relationships is achieved in the following way. Publisher and Book have One-to-Many (1:N) relationship whereby there are multiple books published by the same publisher but owned by a separate publisher and publications respect through the publisher using producer as a foreign key in the Book table. Two Many-to-Many (M:N) relations exist with a Book-Author relationship which can resolve using the book_author junction table and is composed of primary key (isbn, author_id); another one between Book and Warehouse including copies attribute 
to keep track of the number of copies on-site. No One-to-One relationships in this case . There will be a total 
  of six tables: publisher, author, warehouse, book, book author and book warehouse.
<br/>
<img src="https://i.imgur.com/nKjzAWw.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />

  <h2>Normalization Practice::</h2>

  <br />
 a) 1NF Check:
  <br/>All values are atomic (single values per cell). The table satisfies 1NF but has partial and transitive dependencies violating higher normal forms.  <br />

  <br />
 b)Functional Dependencies
: <br />
  <br/>Book_ISBN → Book_Title, Publisher_ID, Publisher_Name  
  <br />Author_ID → Author_Name 
  <br /> Publisher_ID → Publisher_Name   
   <br /> (Book_ISBN, Warehouse_Code) → Copies
 <br />

   <br /> c & d) Normalization Steps with Tables

 <br />
<img src="https://i.imgur.com/SSRmpRk.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
2NF — Remove Partial Dependencies (attributes depending on only part of composite key):
: <br/>
 <br />Book Table:  
 <br/>

<img src="https://i.imgur.com/jTu7IRS.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
3NF — Remove Transitive Dependency (Publisher_Name depends on Publisher_ID, not Book_ISBN):
 <br/>
 <br/>
 
 <br/>
Publisher Table:

<img src="https://i.imgur.com/rUhtoA8.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />

<img src="https://i.imgur.com/ZY8HiK1.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />

