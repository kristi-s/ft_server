<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wp_base' );

/** MySQL database username */
define( 'DB_USER', 'root' );

/** MySQL database password */
define( 'DB_PASSWORD', '' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'kU;/2GCgxfLbM4J `+Mt_|/<V&n`p-4&-SYJtK6$Rld16veP0u%3*2T`Y]i%E3[~');
define('SECURE_AUTH_KEY',  '|yfHjJCKtR|+)[<`i|JXp`ib :c+l77C5Uz*MB<59D>$h;pi6IrynU!$-C/JcPlW');
define('LOGGED_IN_KEY',    '/#T8EP!e5ryK@4WuGE+![_-&>VI]*EKZ8[f{x((|P->U|cKtxyUR+jES1o~r0!^W');
define('NONCE_KEY',        'YofStl&%cOI*lnVId>(Mn!DP vdS;[C.{4F<|@EIaEEt`HB*H&)H||Kul#KevxMq');
define('AUTH_SALT',        ' zp][IK3fGQfA|$sJg-S[XwF-Z);T#z.WLs8]+nI.ESoPya;as1*%0b g=(<(dnM');
define('SECURE_AUTH_SALT', 'N_I2b{Mm,*LM2n,7b_z|_bnnN7uk@TI;|<N5R?ft^bKX,GrAdfh7S(Q?*#TQmK9e');
define('LOGGED_IN_SALT',   '~Kcr|%sDz)]-.2v/,dgEDE/=.q4,ThQch.DH2|vR|tY$T+,rD=5FPz+C-@,Mt]AY');
define('NONCE_SALT',       'LqwD@*(ed+*|{mgCBM{B?WH a87Ko-i6ofai||nSlzo?ME|;jo7gIy0g1rHMe+yR');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
