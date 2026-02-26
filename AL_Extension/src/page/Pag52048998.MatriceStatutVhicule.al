Page 52048998 "Matrice Statut - Véhicule"
{//GL2024  ID dans Nav 2009 : "39004746"
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Véhicule";
    SourceTableView = where("N° Vehicule" = filter('CM*' | 'TR*'),
                            Bloquer = const(false));
    ApplicationArea = All;

    layout
    {
    }

    actions
    {
    }

    var
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        DateFilter: Text[30];
        TypeC: Option Mission,Reparation,Vignette,"Visite Technique",Taxe,"Afficher tous";
        FilVehicule: Code[10];
        StatutVehicule: Option Disponible,Fonctionnel,"En Panne","En Reparation","Hors Service"," ";
        Mission: Record Missions;
        rep: Record "Réparation Véhicule";
        Vig: Record "Vignette Véhicule";
        //GL3900    Visite: Record "Visite Technique";
        Taxe: Record Taxe;
        Selected: Integer;
        Text000: label 'Mission,Réparation,Visite Technique,Vignette,Taxe';
        Miss: Record Missions;
        repa: Record "Réparation Véhicule";
        Vign: Record "Vignette Véhicule";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ParcSetup: Record "Paramétre Parc";
        //GL3900   SuiviVehiculeParStatutEnr: Record "Lig Programmation Enr";
        DateDebut: Date;
        DateFin: Date;


    procedure setvendorfilter()
    begin
    end;

    local procedure FindPeriod(SearchText: Code[10])
    var
        GLAcc: Record "G/L Account";
        Calendar: Record Date;
    //PeriodFormMgt: Codeunit 359;
    begin
    end;


    procedure VerifReparation() VarRep: Boolean
    var
    //GL3900     SuiviVehiculeParStatutEnr: Record "Lig Programmation Enr";
    begin
    end;


    procedure VerifMission() VarMiss: Boolean
    begin
    end;


    procedure VerifVignette(Vehicule: Record "Véhicule"; DateRep: Date; DateFrep: Date) VarVig: Boolean
    begin
    end;


    procedure VerifVisitetech(Vehicule: Record "Véhicule"; DateRep: Date; DateFrep: Date) VarVis: Boolean
    begin
    end;


    procedure VerifTaxe(Vehicule: Record "Véhicule"; DateRep: Date; DateFrep: Date) Vartaxe: Boolean
    begin
    end;
}

