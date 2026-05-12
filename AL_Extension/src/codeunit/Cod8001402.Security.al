Codeunit 8001402 Security
{
    // //+BGW+PKI GESWAY 29/11/00 Gestion des sécurités Add-On


    trigger OnRun()
    begin
    end;


    procedure CreerSecurite(Groupe: Code[20]; NomGroupe: Text[30]; TypeObjet: Option "Table Data","Table",Form,"Report",Dataport,"Codeunit",,,,,System; Lecture: Option " ",Oui,Indirect; Ecriture: Option " ",Oui,Indirect; NumeroTableDebut: Integer; NumeroTableFin: Integer)
    var
        //GL2024 MembreDe: Record 2000000003;
        GroupeSecurite: Record "Permission Set";
        //GL2024 License "Objet": Record "Object";
        //GL2024 License
        "Objet": Record AllObj;
        //GL2024 License
        NewTypeObjet: Option "Table Data","Table",Form,"Report",Dataport,"Codeunit",,,,,System;
    begin
        if /*GL2024 (MembreDe.WritePermission) or*/ (StrPos(COMPANYNAME, 'CRONUS') = 1) then begin
            if not GroupeSecurite.Get(Groupe) then begin
                GroupeSecurite.Init;
                GroupeSecurite."Role ID" := Groupe;
                GroupeSecurite.Name := NomGroupe;
                GroupeSecurite.Insert;
            end;
            NewTypeObjet := TypeObjet;
            if NewTypeObjet = 0 then
                NewTypeObjet := 1;
            repeat
                if (NumeroTableDebut = 2000000001) or (TypeObjet = Typeobjet::System) or (Objet.Get(NewTypeObjet, '', NumeroTableDebut)) then
                    CreerAutorisation(Groupe, NumeroTableDebut, TypeObjet, Lecture, Ecriture);
                NumeroTableDebut := NumeroTableDebut + 1;
            until NumeroTableDebut > NumeroTableFin;
        end;
    end;


    procedure CreerAutorisation(Groupe: Code[20]; NumeroTable: Integer; TypeObjet: Option "Table Data","Table",Form,"Report",Dataport,"Codeunit",,,,,System; Lecture: Option " ",Oui,Indirect; Ecriture: Option " ",Oui,Indirect)
    var
        Autorisation: Record Permission;
    begin
        if not Autorisation.Get(Groupe, TypeObjet, NumeroTable) then
            with Autorisation do begin
                Init;
                "Role ID" := Groupe;
                "Object Type" := TypeObjet;
                "Object ID" := NumeroTable;
                "Read Permission" := "Read Permission";
                "Insert Permission" := Ecriture;
                "Modify Permission" := Ecriture;
                "Delete Permission" := Ecriture;
                Insert;
            end;
    end;
}

