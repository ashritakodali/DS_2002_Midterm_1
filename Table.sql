use sales;

DROP TABLE IF EXISTS Deliver_To;
DROP TABLE IF EXISTS Contain;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Manage;
DROP TABLE IF EXISTS Purchasers;
DROP TABLE IF EXISTS After_Sales_Service_At;

DROP TABLE IF EXISTS Address;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS OrderItem;
DROP TABLE IF EXISTS CreditCard;
DROP TABLE IF EXISTS DebitCard;
DROP TABLE IF EXISTS BankCard;
DROP TABLE IF EXISTS Seller;
DROP TABLE IF EXISTS Comments;
DROP TABLE IF EXISTS Buyer;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Store;
DROP TABLE IF EXISTS ServicePoint;
DROP TABLE IF EXISTS Brand;

-- Entity
CREATE TABLE Users
(
    userid INT NOT NULL
    ,name VARCHAR(20)
    ,phoneNumber VARCHAR(20)
    ,PRIMARY KEY(userid)
);

CREATE TABLE Buyer
(
    userid INT NOT NULL
    ,PRIMARY KEY(userid)
    ,FOREIGN KEY(userid) REFERENCES Users(userid)
);

CREATE TABLE Seller
(
    userid INT NOT NULL
    ,PRIMARY KEY(userid)
    ,FOREIGN KEY(userid) REFERENCES Users(userid)
);

CREATE TABLE BankCard
(
    cardNumber VARCHAR(25) NOT NULL
    ,expiryDate DATE
    ,bank VARCHAR(20)
    ,PRIMARY KEY(cardNumber)
);

CREATE TABLE
CreditCard
(
    cardNumber VARCHAR(25) NOT NULL
    ,userid INT NOT NULL
    ,organization VARCHAR(20)
    ,PRIMARY KEY(cardNumber)
    ,FOREIGN KEY(cardNumber) REFERENCES BankCard(cardNumber)
    ,FOREIGN KEY(userid) REFERENCES Users(userid)
);

CREATE TABLE DebitCard
(
    cardNumber VARCHAR(25) NOT NULL
    ,userid INT NOT NULL
    ,PRIMARY KEY(cardNumber)
    ,FOREIGN KEY(cardNumber) REFERENCES BankCard(cardNumber)
    ,FOREIGN KEY(userid) REFERENCES Users(userid)
);

CREATE TABLE Address
(
    addrid INT NOT NULL
    ,userid INT NOT NULL
    ,name VARCHAR(50)
    ,contactPhoneNumber VARCHAR(20)
    ,province VARCHAR(100)
    ,city VARCHAR(100)
    ,streetaddr VARCHAR(100)
    ,postCode VARCHAR(12)
    ,PRIMARY KEY(addrid)
    ,FOREIGN KEY(userid) REFERENCES Users(userid)
);

CREATE TABLE Store
(
    sid INT NOT NULL
    ,name VARCHAR(20)
    ,province VARCHAR(20)
    ,city VARCHAR(20)
    ,streetaddr VARCHAR(20)
    ,customerGrade INT
    ,startTime DATE
    ,PRIMARY KEY(sid)
);

CREATE TABLE Brand
(
    brandName VARCHAR(20) NOT NULL
    ,PRIMARY KEY (brandName)
);

CREATE TABLE Product
(
    pid INT NOT NULL
    ,sid INT NOT NULL
    ,brand VARCHAR(50) NOT NULL
    ,name VARCHAR(100)
    ,type VARCHAR(50)
    ,modelNumber VARCHAR(50)
    ,color VARCHAR(50)
    ,amount INT
    ,price INT
    ,PRIMARY KEY(pid)
    ,FOREIGN KEY(sid) REFERENCES Store(sid)
    ,FOREIGN KEY(brand) REFERENCES Brand(brandName)
);

CREATE TABLE OrderItem
(
    itemid INT NOT NULL
    ,pid INT NOT NULL
    ,price INT
    ,creationTime DATE
    ,PRIMARY KEY(itemid)
    ,FOREIGN KEY(pid) REFERENCES Product(pid)
);

CREATE TABLE Orders
(
    orderNumber INT NOT NULL
    ,paymentState VARCHAR(12)
    ,creationTime DATE
    ,totalAmount INT
    ,PRIMARY KEY (orderNumber)
);


CREATE TABLE Comments  -- Weak Entity
(
    creationTime DATE NOT NULL
    ,userid INT NOT NULL
    ,pid INT NOT NULL
    ,grade FLOAT
    ,content VARCHAR(500)
    ,PRIMARY KEY(creationTime,userid,pid)
    ,FOREIGN KEY(userid) REFERENCES Buyer(userid)
    ,FOREIGN KEY(pid) REFERENCES Product(pid)
);

CREATE TABLE ServicePoint
(
    spid INT NOT NULL
    ,streetaddr VARCHAR(40)
    ,city VARCHAR(30)
    ,province VARCHAR(20)
    ,startTime VARCHAR(20)
    ,endTime VARCHAR(20)
    ,PRIMARY KEY(spid)
);
-- Relationship

CREATE TABLE Purchasers
(
    userid INT NOT NULL
    ,pid INT NOT NULL
    ,addTime DATE
    ,quantity INT
    ,PRIMARY KEY (userid,pid)
    ,FOREIGN KEY(userid) REFERENCES Buyer(userid)
    ,FOREIGN KEY(pid) REFERENCES Product(pid)
);

CREATE TABLE Contain
(
    orderNumber INT NOT NULL
    ,itemid INT NOT NULL
    ,quantity INT
    ,PRIMARY KEY (orderNumber,itemid)
    ,FOREIGN KEY(orderNumber) REFERENCES Orders(orderNumber)
    ,FOREIGN KEY(itemid) REFERENCES OrderItem(itemid)
);

CREATE TABLE Payment
(
    orderNumber INT NOT NULL
    ,creditcardNumber VARCHAR(25) NOT NULL
    ,payTime DATE
    ,PRIMARY KEY(orderNumber,creditcardNumber)
    ,FOREIGN KEY(orderNumber) REFERENCES Orders(orderNumber)
    ,FOREIGN KEY(creditcardNumber) REFERENCES CreditCard(cardNumber)
);

CREATE TABLE Deliver_To
(
    addrid INT NOT NULL
    ,orderNumber INT NOT NULL
    ,TimeDelivered DATE
    ,PRIMARY KEY(addrid,orderNumber)
    ,FOREIGN KEY(addrid) REFERENCES Address(addrid)
    ,FOREIGN KEY(orderNumber) REFERENCES Orders(orderNumber)
);

CREATE TABLE Manage
(
    userid INT NOT NULL
    ,sid INT NOT NULL
    ,SetUpTime DATE
    ,PRIMARY KEY(userid,sid)
    ,FOREIGN KEY(userid) REFERENCES Seller(userid)
    ,FOREIGN KEY(sid) REFERENCES Store(sid)
);

CREATE TABLE After_Sales_Service_At
(
    brandName VARCHAR(20) NOT NULL
    ,spid INT NOT NULL
    ,PRIMARY KEY(brandName, spid)
    ,FOREIGN KEY(brandName) REFERENCES Brand (brandName)
    ,FOREIGN KEY(spid) REFERENCES ServicePoint(spid)
);