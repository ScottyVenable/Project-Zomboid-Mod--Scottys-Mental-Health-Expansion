BipolarTraits = {}

function BipolarTraits.addTraits()
    TraitFactory.addTrait("BipolarI", "Bipolar I", -4, "Prone to manic and depressive episodes.", false)
    TraitFactory.addTrait("BipolarII", "Bipolar II", -4, "Experiences hypomanic and depressive episodes.", false)
    TraitFactory.addTrait("BipolarIPsychotic", "Bipolar I - Psychotic", -6, "Manic episodes may include psychosis.", false)
end

Events.OnGameBoot.Add(BipolarTraits.addTraits)
