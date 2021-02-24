const passport = require("passport");
const LocalStrategy = require("passport-local").Strategy;

const pool = require("../database");
const helpers = require("./helpers");

passport.use(
  "local.signin",
  new LocalStrategy(
    {
      usernameField: "username",
      passwordField: "password",
      passReqToCallback: true
    },
    async (req, username, password, done) => {
      const rows = await pool.query("SELECT * FROM users WHERE username = ?", [
        username
      ]);
      if (rows.length > 0) {
        const user = rows[0];
        console.log(user);
        console.log(password);
        const validPassword = await helpers.matchPassword(
          password,
          user.password
        );
        if (validPassword) {
          done(null, user, req.flash("success", "Bienvenido" + user.username));
        } else {
          done(null, false, req.flash("message", "Contreseña Incorrecta"));
        }
      } else {
        return done(
          null,
          false,
          req.flash("message", "El Usuario no existe.")
        );
      }
    }
  )
);

passport.use(
  "local.signup",
  new LocalStrategy(
    {
      usernameField: "username",
      passwordField: "password",
      passReqToCallback: true
    },
    async (req, username, password, done) => {
      const { fullname , idroles } = req.body;

      let newUser = {
        fullname,
        username,
        password,
        Idroles : idroles
      };
      newUser.password = await helpers.encryptPassword(password);
      // Saving in the Database
      const result = await pool.query("INSERT INTO users SET ? ", newUser);
      newUser.idUSUARIO = result.insertId;
      return done(null, newUser);
    }
  )
);

passport.serializeUser((user, done) => {
  done(null, user.idUSUARIO);
});

passport.deserializeUser(async (idUSUARIO, done) => {
  const rows = await pool.query("SELECT * FROM users WHERE idUsuario = ?", [idUSUARIO]);
  done(null, rows[0]);
});
