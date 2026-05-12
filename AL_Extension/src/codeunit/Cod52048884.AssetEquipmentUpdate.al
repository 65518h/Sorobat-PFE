Codeunit 52048884 "Asset/Equipment Update"
{
    //GL2024  ID dans Nav 2009 : "39002011"
    trigger OnRun()
    begin
    end;

    var
        Asset: Record "Fixed Asset";
        text001: label 'This fixed asset %1 is already affected to the equipment %2';
        text002: label 'The equipment %1 was created and affected to the fixed asset %2';

    //GL3900
    /*
        procedure AssetUpdate(Equipment: Record Equipement)
        begin
            Asset.Get(Equipment."Immo No.");
            Asset.Description := CopyStr(Equipment.Désignation, 1, 30);
            Asset."FA Subclass Code" := 'MACHINE';
            Equipment.CalcFields(Equipment.Picture);
            //GL2024    Asset.Picture := Equipment.Picture;
            Asset.Image := Equipment.Picture;
            Asset.Modify(true)
        end;


        procedure EquipToAsset(OldEquipment: Record Equipement; Equipment: Record Equipement)
        begin
            if (Equipment."Immo No." <> '') and
               ((OldEquipment."Immo No." <> Equipment."Immo No.") or
                (OldEquipment.Désignation <> Equipment.Désignation))

            then
                AssetUpdate(Equipment)
            else
                exit;
        end;


        procedure CeateEquipment(Asset: Record "Fixed Asset")
        var
            Equipment: Record Equipement;
        begin
            Equipment.Reset;
            Equipment.SetFilter(Equipment."Immo No.", Asset."No.");
            if Equipment.Find('-') then
                Message(text001, Asset."No.", Equipment.cd_box)
            else begin
                Equipment.Init;
                Equipment.Désignation := Asset.Description;
                Equipment."Immo No." := Asset."No.";
                //GL2024  Asset.CalcFields(Asset.Picture);
                Asset.CalcFields(Asset.Image);
                //GL2024   Equipment.Picture := Asset.Picture;
                Equipment.Picture := Asset.Image;
                Equipment.Insert(true);
                Message(text002, Equipment.cd_box, Asset."No.");
            end;
        end;


        procedure MatriculeToAsset(OldMatricule: Record Matricule; Matricule: Record Matricule)
        begin
            if (Matricule."Immo No." <> '') and
               ((OldMatricule."Immo No." <> Matricule."Immo No.") or
                (OldMatricule.designation <> Matricule.designation))

            then
                AssetUpdateMat(Matricule)
            else
                exit;
        end;


        procedure AssetUpdateMat(matricule: Record Matricule)
        begin
            Asset.Get(matricule."Immo No.");
            Asset.Description := CopyStr(matricule.designation, 1, 30);
            Asset."FA Subclass Code" := 'MACHINE';
            matricule.CalcFields(matricule.Picture);
            //GL2024   Asset.Picture := matricule.Picture;
            Asset.Image := matricule.Picture;
            Asset.Modify(true)
        end;
        */
    //GL3900
}

