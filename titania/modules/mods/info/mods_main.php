<?php
/**
 *
 * @package titania
 * @version $Id$
 * @copyright (c) 2008 phpBB Customisation Database Team
 * @license http://opensource.org/licenses/gpl-license.php GNU Public License
 *
 */

class mods_main_info
{
	function module()
	{
		return array(
			'modes'		=> array(
				'categories'		=> array('title' => 'MODS_CATEGORIES', 'auth' => ''),
				'list'				=> array('title' => 'MODS_LIST', 'auth' => ''),
			),
		);
	}
}

?>