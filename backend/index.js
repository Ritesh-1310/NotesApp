// // Initialization 
// require("dotenv").config();

// const express = require('express');
// const app = express();

// const mongoose = require('mongoose');
// // const Note = require('./models/Note');

// const bodyParser = require('body-parser');
// app.use(bodyParser.urlencoded({ extended: false }));
// app.use(bodyParser.json());

// mongoose.set('strictQuery', true);

// const mongoDbPath = process.env.mongoDbPath


// mongoose.connect(mongoDbPath).then(function() {
//     app.get("/api", function(req, res) {
//         const response = { statuscode: res.statusCode, message: "API Works!" };
//         res.json(response);
//     });
    
//     const noteRouter = require('./routes/Note');
//     app.use("/notes", noteRouter);
// });

// // Starting the server on a PORT
// const PORT = process.env.PORT || 8000;
// app.listen(PORT, function() {
//     console.log("Server started at PORT: " + PORT);
// });

//--------------------------------------------------------------
require("dotenv").config();

const express = require('express');
const app = express();
const mongoose = require('mongoose');
const bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

mongoose.set('strictQuery', true);

const mongoDbPath = process.env.mongoDbPath;

mongoose.connect(mongoDbPath, { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => {
        console.log("MongoDB connected...");

        app.get("/api", (req, res) => {
            const response = { statuscode: res.statusCode, message: "API Works!" };
            res.json(response);
        });

        const noteRouter = require('./routes/Note');
        app.use("/notes", noteRouter);

        const PORT = process.env.PORT || 8000;
        app.listen(PORT, () => {
            console.log(`Server started at PORT: ${PORT}`);
        });
    })
    .catch(err => console.log(err));

    