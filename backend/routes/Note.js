const express = require('express');
const router = express.Router();
const Note = require('./../models/Note');

router.post("/list", async (req, res) => {
    try {
        const notes = await Note.find({ userid: req.body.userid });
        res.json(notes);
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

router.post("/add", async (req, res) => {
    try {
        await Note.deleteOne({ id: req.body.id });

        const newNote = new Note({
            id: req.body.id,
            userid: req.body.userid,
            title: req.body.title,
            content: req.body.content
        });
        await newNote.save();

        res.json({ message: "New Note Created! id: " + req.body.id });
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

router.post("/delete", async (req, res) => {
    try {
        await Note.deleteOne({ id: req.body.id });
        res.json({ message: "Note Deleted! id: " + req.body.id });
    } catch (err) {
        res.status(500).json({ message: err.message });
    }
});

module.exports = router;
