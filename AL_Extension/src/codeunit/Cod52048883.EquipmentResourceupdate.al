Codeunit 52048883 "Equipment/Resource update"
{
    //GL2024  ID dans Nav 2009 : "39002010"
    trigger OnRun()
    begin
    end;

    var
        Res: Record Resource;
    //GL3900
    /*
        procedure ResUpdate(equipement: Record Equipement)
        begin
            Res.Get(equipement."Resource No.");
            Res.Name := CopyStr(equipement.Désignation, 1, 30);
            //
            equipement.CalcFields(Picture);//.CREATEOUTSTREAM(ObjOut);
            Res.Image := equipement.Picture;
            //Res.Picture.CREATEINSTREAM(Objin);
            Res.Modify(true)
        end;


        procedure EquipToRes(OldEquipement: Record Equipement; Equipement: Record Equipement)
        begin
            if (Equipement."Resource No." <> '') and
               ((OldEquipement."Resource No." <> Equipement."Resource No.") or

                (OldEquipement.Désignation <> Equipement.Désignation))

            then
                ResUpdate(Equipement)
            else
                exit;
        end;*/
    //GL3900
}

