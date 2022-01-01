# ArM CharSheet/Journal Sketch

(class names are Capitalised)

## Main classes

+ Character object contains
    + MetaData (name, birth year, player, etc)
    + List of JournalEntry objects
+ JournalEntry object contains
    + Time reference, which is either
        + a Season
        + a pre-game stage (early childhood, etc.)
    + Activity objects each of which contains
        + narrative description (String)
        + TraitDelta objects
        + (more mechanical properties may be added later, but for an MVP,
          I am only interested in the TraitDelta)
+ CharacterSheet object contains
    + Time reference (as for JournalEntry)
    + Character reference
    + collection of Trait objects which contains
        + method to apply a single TraitDelta object to make a 
          new Trait object
    + method to apply a sequence of TraitDelta object to 
      return a CharacterSheet for the next Time
        + (we might feed in a JournalEntry, but I assume here that
          the TraitDelta contains the mechanical information, and
          that we do not want to couple CharacterSheet with the
          more complex JournalEntry)
    + methods to pull data for the view
        1. pull Character metadata
        1. pull collection of Trait objects, probably by type
           (ability, characteristic, etc.)

**Note** the above has been described in terms of immutable objects.
If we work instead with mutable objects, the CharacterSheet may look 
like

+ CharacterSheet object contains
    + Character reference
    + JournalEntry reference
    + CharacterSheet reference (from previous Time step) 
    + collection of Trait objects which contains
        + method to apply a single TraitDelta object to make a 
          new Trait object
    + a listener interface which listens to changes in the previous
      CharacterSheet and JournalEntry, recomputing traits as required,
      by applying TraitDelta from JournalEntry to Trait from CharacterSheet.
    + methods to pull data for the view
        1. pull Character metadata
        1. pull collection of Trait objects, probably by type
           (ability, characteristic, etc.)

## Subclassing
    
+ TraitDelta 
    + New trait
    + Remove trait
    + Add XP
    + Change value (e.g. personality trait)

+ Trait
    + XPtraits (note also the accellerated/difficult dichotomy)
        + arts 
        + abilities
    + Characteristic
    + PersonaltyTrait
    + VirtueFlaw
    + Spell
    + Reputation
    + Confidence
    + Warping
    + Decreptitude

## Questions

1. How do we identify instances of the same trait?
    + type system - i.e. make classes for every canon trait, and
      let the trait in the CharacterSheet be an instance of the right
      class.  This makes custom traits difficult.
    + reference - i.e. make TraitDescripton class, whose objects
      contain canon names and descriptions, as well as a unique ID
      for reference.
2. How does the TraitDelta reference the trait to be updated?
    + Unique ID (string)
    + Reference to Trait object
    + Reference to TraitDescription object or Class/Type 
      depending on the solution chosen above
    + A reference to a Trait object is probably a bad idea, because
      the Trait object may disappear if changes are made to previous
      time steps.
