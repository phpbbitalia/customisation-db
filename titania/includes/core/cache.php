<?php
/**
 *
 * @package titania
 * @version $Id$
 * @copyright (c) 2008 phpBB Customisation Database Team
 * @license http://opensource.org/licenses/gpl-license.php GNU Public License
 *
 */

/**
* @ignore
*/
if (!defined('IN_TITANIA'))
{
	exit;
}

class titania_cache extends acm
{
	/**
	 * Constructor
	 */
	public function acm()
	{
		parent::acm();
		$this->cache_dir = phpbb_realpath($this->cache_dir) . '/';
	}

	/**
	 * Get categories by tag type
	 *
	 * @return array of categories
	 */
	public function get_categories()
	{
		$categories = $this->get('_titania_categories');

		if ($categories === false)
		{
			$categories = array();

			$sql = 'SELECT *
				FROM ' . TITANIA_CATEGORIES_TABLE . '
				ORDER BY left_id ASC';
			$result = phpbb::$db->sql_query($sql);

			while ($row = phpbb::$db->sql_fetchrow($result))
			{
				$categories[$row['category_id']] = $row;
			}
			phpbb::$db->sql_freeresult($result);

			$this->put('_titania_categories', $categories);
		}

		return $categories;
	}

	/**
	* Get the list of parents for a category
	*
	* @param int $category_id The category id to get the parents for.
	* @return returns an array of the categories parents, ex:
	* array(
	* 	array('category_id' => 2, 'parent_id' =>  1, 'category_name_clean' => 'Modifications'),
	* 	array('category_id' => 1, 'parent_id' =>  0, 'category_name_clean' => 'phpBB3'),
	* ),
	*/
	public function get_category_parents($category_id)
	{
		$parent_list = $this->get('_titania_category_parents');

		if ($parent_list === false)
		{
			$parent_list = $list = array();

			$sql = 'SELECT category_id, parent_id, category_name_clean FROM ' . TITANIA_CATEGORIES_TABLE . '
				ORDER BY left_id ASC';
			$result = phpbb::$db->sql_query($sql);

			while ($row = phpbb::$db->sql_fetchrow($result))
			{
				// need later
				$list[$row['category_id']] = $row;

				$parent_id = $row['parent_id'];

				// Go through and grab all of the parents
				while (isset($list[$parent_id]))
				{
					$parent_list[$row['category_id']][] = $list[$parent_id];

					$parent_id = $list[$parent_id]['parent_id'];
				}
			}

			phpbb::$db->sql_freeresult($result);

			$this->put('_titania_category_parents', $parent_list);
		}

		return (isset($parent_list[$category_id])) ? $parent_list[$category_id] : array();
	}

	/**
	* Get the author contribs for the specified user id
	*
	* @param int $user_id The user ID
	*
	* @return array Array of contrib_id's
	*/
	public function get_author_contribs($user_id)
	{
		$author_id = (int) $author_id;

		// We shall group authors by id in groups of 2500
		$author_block_name = '_titania_authors_' . floor($user_id / 2500);

		$author_block = $this->get($author_block_name);

		if ($author_block !== false)
		{
			if (isset($author_block[$user_id]))
			{
				return $author_block[$user_id];
			}
		}
		else
		{
			// Else the cache file did not exist and we need to start over
			$author_block = array();
		}

		$author_block[$user_id] = array();

		// Need to get the contribs for the selected author
		$sql = 'SELECT contrib_id FROM ' . TITANIA_CONTRIBS_TABLE . '
			WHERE contrib_user_id = ' . $user_id;
		$result = phpbb::$db->sql_query($sql);

		while ($row = phpbb::$db->sql_fetchrow($result))
		{
			$author_block[$user_id][] = $row['contrib_id'];
		}

		phpbb::$db->sql_freeresult($result);

		// Now get the lists where the user is a co-author
		$sql = 'SELECT contrib_id FROM ' . TITANIA_CONTRIB_COAUTHORS_TABLE . '
			WHERE user_id = ' . $user_id;
		$result = phpbb::$db->sql_query($sql);
		while ($row = phpbb::$db->sql_fetchrow($result))
		{
			$author_block[$user_id][] = $row['contrib_id'];
		}
		phpbb::$db->sql_freeresult($result);

		// Store the updated cache data
		$this->put($author_block_name, $author_block);

		return $author_block[$user_id];
	}

	/**
	* Obtain allowed extensions
	*
	* @return array allowed extensions array.
	*/
	public function obtain_attach_extensions()
	{
		if (($extensions = $this->get('_titania_extensions')) === false)
		{
			$extensions = array();

			$sql = 'SELECT e.extension, g.*
				FROM ' . EXTENSIONS_TABLE . ' e, ' . EXTENSION_GROUPS_TABLE . ' g
				WHERE e.group_id = g.group_id';
			$result = phpbb::$db->sql_query($sql);

			while ($row = phpbb::$db->sql_fetchrow($result))
			{
				$extension = strtolower(trim($row['extension']));

				$extensions[$row['group_name']][$extension] = array(
					'display_cat'	=> (int) $row['cat_id'],
					'download_mode'	=> (int) $row['download_mode'],
					'upload_icon'	=> trim($row['upload_icon']),
					'max_filesize'	=> (int) $row['max_filesize'],
				);
			}
			 phpbb::$db->sql_freeresult($result);

			$this->put('_titania_extensions', $extensions);
		}

		return $extensions;
	}
}
