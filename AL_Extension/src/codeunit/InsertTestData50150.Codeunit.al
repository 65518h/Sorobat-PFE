codeunit 50150 "InsertTestData"
{
    trigger OnRun()
    var
        Chef: Record "Chef Chantier";
    begin
        Chef.Init();
        Chef.Id := CreateGuid();
        Chef."Nom et Prenom" := 'Test PFE';
        Chef."Adresse Email" := 'votre.email@exemple.com'; 
        Chef."Num Projet" := 'AEROPORT_DONSIN';
        Chef.Actif := true;
        if Chef.Insert() then
            Message('Données de test insérées avec succès !')
        else
            Error('Erreur lors de l''insertion.');
    end;
}