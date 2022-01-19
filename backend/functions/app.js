const express = require("express");
const router = require("./router/router");
const cors = require("cors");
const mongoose = require("mongoose");
const app = express();

//middleware
app.use(express.json());
app.use(cors());

// router
app.get("/", (req, res) => res.send("Home Page"));
app.use("/api", router);

//database connection
mongoose
  //.connect("mongodb://localhost/Todo-database")
  .connect("mongodb+srv://admin:admin@cluster0.a3shi.mongodb.net/Todo-database?retryWrites=true&w=majority", { useNewUrlParser: true } )
  .then((val) => console.log("Conected to db"))
  .catch((err) => console.log("could not connect to database ", err));

//listning to prot
// const port = process.env.PORT || 3000;
//app.listen(port, () => console.log(`listening on port ${port}`));

module.exports = app;
