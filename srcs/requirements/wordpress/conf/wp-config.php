<?php

do{
	$mysqli = @new mysqli('mariadb', getenv('MYSQL_USER'), getenv('MYSQL_PASSWORD'), getenv('MYSQL_DATABASE'));
    sleep(3);
}while ($mysqli->connect_errno);
$mysqli->close();

/** Enable W3 Total Cache */
define('WP_CACHE', true); // Added by W3 Total Cache

define( 'DB_NAME', getenv('MYSQL_DATABASE') );
define( 'DB_USER', getenv('MYSQL_USER')  );
define( 'DB_PASSWORD', getenv('MYSQL_PASSWORD') );
define( 'DB_HOST', getenv('MYSQL_HOST') );

define( 'AUTH_KEY',         'Dl,oA[&k;uhaz[Nno}>RWE.E:9w91?gsq.(@GsigAX)k!8291R iRTey~KivPD+6' );
define( 'SECURE_AUTH_KEY',  'PHNN* @fC)|?4Dc+K8<ni0n$~`l``kxDXB/#(vXT`mFnk]u^I,-kRUiWU3~EJ$_~' );
define( 'LOGGED_IN_KEY',    'B9o3^jG%]o[WD5vik?~x-@JEqV]8e>CPcLZpV3->h)>28|l45i)a%L&7DpCI5p84' );
define( 'NONCE_KEY',        'LlP?W;fa;]L3B-4Ec>WefV)2hF~79xWK@$L86:Pq4Q|.ss_MvL~x-EiM(J2Ys~-N' );
define( 'AUTH_SALT',        'zRG>P((JJ:EsB|f/RN31nXE$JI/Vs4$vtlEnya9=rE9&=:^=e6EeuZ)8*IZNj9It' );
define( 'SECURE_AUTH_SALT', 'mz4_)o;:;l-O2Q#x/Z4ajTdF!f$P~9!=;x^F:$R[`Dh(biNH]/oA9.;U9/#}D#ya' );
define( 'LOGGED_IN_SALT',   '8kjeQ:Q-/@^KDmrFb3r}j3{u`ExQu]3N(w0  &m.zyF|tfPqq4FMfW^B-c1{Jj17' );
define( 'NONCE_SALT',       'fcVaZ=!xASRM>3dokSEaB_;s]?Xi059BE7y3Q/ToOf]sLc[!BC)WGR(?}J{%=l<.' );

$table_prefix = 'wp_';


define( 'WP_DEBUG', false );

if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';