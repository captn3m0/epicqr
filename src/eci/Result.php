<?php
/**
 * Generated by Haxe 4.3.3
 */

namespace eci;


class Result {
	/**
	 * @var string
	 */
	public $epic;
	/**
	 * @var int
	 */
	public $id;

	/**
	 * @param string $epic
	 * @param int $id
	 * 
	 * @return void
	 */
	public function __construct ($epic, $id) {
		$this->epic = $epic;
		$this->id = $id;
	}
}
