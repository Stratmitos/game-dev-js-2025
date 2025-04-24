extends Panel

var public_trust: int = 100

var base_tax: int = 100

var day_passed: int = 0

var tax_earned: int = 100

func _ready() -> void:
	set_public_trust(public_trust)
	set_base_tax(base_tax)
	set_day_passed(day_passed)
	set_tax_earned(tax_earned)

func set_public_trust(value: int) -> void:
	public_trust = value
	$PublicTrust.text = "Public Trust: %d" % public_trust

func get_public_trust() -> int:
	return public_trust

func set_base_tax(value: int) -> void:
	base_tax = value
	$BaseTax.text = "Base Tax: %d" % base_tax

func get_base_tax() -> int:
	return base_tax

func set_day_passed(value: int) -> void:
	day_passed = value
	$Day.text = "Day: %d" % day_passed

func get_day_passed() -> int:
	return day_passed

func set_tax_earned(value: int) -> void:
	tax_earned = value
	$TaxEarned.text = "Tax Earned Today: %d" % tax_earned

func get_tax_earned() -> int:
	return tax_earned
