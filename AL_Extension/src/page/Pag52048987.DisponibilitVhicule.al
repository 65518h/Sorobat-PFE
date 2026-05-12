Page 52048987 "Disponibilité - Véhicule"
{//GL2024  ID dans Nav 2009 : "39004725"
    PageType = List;
    SourceTable = "Véhicule";
    ApplicationArea = all;
    UsageCategory = Lists;
    Caption = 'Disponibilité - Véhicule';
    layout
    {
        area(content)
        {
            group("<Général>")
            {
                Caption = '<Général>';
                field("Type d'indisponibilité"; TypeC)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        FindPeriod('');
                        CurrPage.Update;
                    end;
                }
                field("Filtre Véhicule"; FilVehicule)
                {
                    ApplicationArea = Basic;

                    trigger OnValidate()
                    begin
                        Rec.Reset;
                        if FilVehicule <> '' then Rec.SetFilter("N° Vehicule", '%1', FilVehicule);
                        CurrPage.Update;
                    end;
                }
                repeater(Group)
                {

                    field("<N° Vehicule>"; REC."N° Vehicule")
                    {
                        ApplicationArea = Basic;
                        Caption = '<N° Vehicule>';
                    }
                    field("<Désignation>"; Rec.Désignation)
                    {
                        ApplicationArea = Basic;
                        Caption = '<Désignation>';
                    }
                    field("<Immatriculation>"; Rec.Immatriculation)
                    {
                        ApplicationArea = Basic;
                        Caption = '<Immatriculation>';
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnClosePage()
    begin
        Rec.Reset;
    end;

    trigger OnOpenPage()
    begin
        Rec.Reset;
        PeriodType := Periodtype::Day;
        FindPeriod('');
        TypeC := 0;

        //CurrPAGE.Matrix.VISIBLE:=TRUE;
    end;

    var
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";
        DateFilter: Text[30];
        TypeC: Option Mission,Reparation,Vignette,"Visite Technique",Taxe,"Afficher tous";
        FilVehicule: Code[10];
        Mission: Record Missions;
        rep: Record "Réparation Véhicule";
        Vig: Record "Vignette Véhicule";
        //GL3900    Visite: Record "Visite Technique";
        Taxe: Record Taxe;
        Selected: Integer;
        Miss: Record Missions;
        repa: Record "Réparation Véhicule";
        Vign: Record "Vignette Véhicule";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ParcSetup: Record "Paramétre Parc";
        Text000: label 'Mission,Réparation,Visite Technique,Vignette,Taxe';


    procedure setvendorfilter()
    begin
        //GL2024
        /*IF TypeC = 0 THEN
         IF VerifMission(Rec,CurrPAGE.Matrix.MatrixRec."Period Start",
            CurrForm.Matrix.MatrixRec."Period End") THEN
           "Var" := 'Mission'  //'&&&&&&&&'
         ELSE
           "Var" := '';
        
        IF TypeC = 1 THEN
         IF VerifReparation(Rec,CurrForm.Matrix.MatrixRec."Period Start",
            CurrForm.Matrix.MatrixRec."Period End") THEN
           "Var" := 'Réparation'
         ELSE
           "Var" := '';
        
        IF TypeC = 2 THEN
         IF VerifVignette(Rec,CurrForm.Matrix.MatrixRec."Period Start",
             CurrForm.Matrix.MatrixRec."Period End") THEN
           "Var" := 'Vignette'
         ELSE
           "Var" := '';
        
        IF TypeC = 3 THEN
         IF VerifVisitetech(Rec,CurrForm.Matrix.MatrixRec."Period Start",
            CurrForm.Matrix.MatrixRec."Period End") THEN
           "Var" := 'Visite Tech.'
         ELSE
           "Var" := '';
        
        IF TypeC = 4 THEN
         IF VerifTaxe(Rec,CurrForm.Matrix.MatrixRec."Period Start",
            CurrForm.Matrix.MatrixRec."Period End") THEN
           "Var" := 'Taxe'
         ELSE
           "Var" := '';
        
        IF TypeC = 5 THEN BEGIN
         IF VerifMission(Rec,CurrForm.Matrix.MatrixRec."Period Start",
            CurrForm.Matrix.MatrixRec."Period End") THEN
            "Var" := 'Mission'
         ELSE
            IF VerifReparation(Rec,CurrForm.Matrix.MatrixRec."Period Start",
               CurrForm.Matrix.MatrixRec."Period End") THEN
              "Var" := 'Reparation'
            ELSE
               IF VerifVignette(Rec,CurrForm.Matrix.MatrixRec."Period Start",
                  CurrForm.Matrix.MatrixRec."Period End") THEN
                  "Var" := 'Vignette'
               ELSE
                  IF VerifVisitetech(Rec,CurrForm.Matrix.MatrixRec."Period Start",
                     CurrForm.Matrix.MatrixRec."Period End") THEN
                     "Var" := 'Visite technique'
                  ELSE
                     IF VerifTaxe(Rec,CurrForm.Matrix.MatrixRec."Period Start",
                        CurrForm.Matrix.MatrixRec."Period End") THEN
                        "Var" := 'Taxe'
                     ELSE
                        "Var" := 'Dispo';
        END;*/

    end;

    local procedure FindPeriod(SearchText: Code[10])
    var
        GLAcc: Record "G/L Account";
        Calendar: Record Date;
    // PeriodFormMgt: Codeunit 359;
    begin
        //GL2024
        /*CurrForm.Matrix.MatrixRec.SETFILTER("Period Start",'%1',WORKDATE);
      IF NOT PeriodFormMgt.FindDate('+',CurrForm.Matrix.MatrixRec,PeriodType) THEN
       PeriodFormMgt.FindDate('+',CurrForm.Matrix.MatrixRec,PeriodType::Day);
      CurrForm.Matrix.MatrixRec.SETRANGE("Period Start");
      PeriodFormMgt.FindDate(SearchText,CurrForm.Matrix.MatrixRec,PeriodType);
      SETRANGE("Filtre Date",CurrForm.Matrix.MatrixRec."Period Start",CurrForm.Matrix.MatrixRec."Period End"); */
        if Rec.GetRangeMin("Filtre Date") = Rec.GetRangemax("Filtre Date") then
            Rec.SetRange("Filtre Date", Rec.GetRangeMin("Filtre Date"));

    end;


    procedure VerifReparation(Vehicule: Record "Véhicule"; DateRep: Date; DateFrep: Date) VarRep: Boolean
    begin
        rep.Reset;
        rep.SetRange("N° Véhicule", Vehicule."N° Vehicule");
        if rep.Find('-') then
            repeat
                if DateRep in [rep."Date Début Réparation" .. rep."Date Fin réparation"] then
                    VarRep := true
                else
                    if (DateRep <= rep."Date Début Réparation") and (DateFrep >= rep."Date Début Réparation") then
                        VarRep := true
                    else
                        VarRep := false;
            until (VarRep = true) or (rep.Next = 0);
    end;


    procedure VerifMission(Vehicule: Record "Véhicule"; DateRep: Date; DateFrep: Date) VarMiss: Boolean
    begin
        Mission.Reset;
        Mission.SetRange("N° Véhicule", Vehicule."N° Vehicule");
        if Mission.Find('-') then
            repeat
                if DateRep in [Mission."Date Départ" .. Mission."Date Arrivée"] then
                    VarMiss := true
                else
                    if (DateRep <= Mission."Date Départ") and (DateFrep >= Mission."Date Départ") then
                        VarMiss := true
                    else
                        VarMiss := false;
            until (VarMiss = true) or (Mission.Next = 0);
    end;


    procedure VerifVignette(Vehicule: Record "Véhicule"; DateRep: Date; DateFrep: Date) VarVig: Boolean
    begin
        Vig.Reset;
        Vig.SetRange("N° Veh", Vehicule."N° Vehicule");
        if Vig.Find('+') then
            if (DateRep >= Vig."Date Fin de Validité") or (DateFrep >= Vig."Date Fin de Validité") then
                VarVig := true
            else
                VarVig := false;
    end;


    procedure VerifVisitetech(Vehicule: Record "Véhicule"; DateRep: Date; DateFrep: Date) VarVis: Boolean
    begin
        //GL3900 
        /*  Visite.Reset;
          Visite.SetRange("N° Véhicule", Vehicule."N° Vehicule");
          if Visite.Find('+') then
              if (DateRep >= Visite."Date Fin Validité") or (DateFrep >= Visite."Date Fin Validité") then
                  VarVis := true
              else
                  VarVis := false;*/ //GL3900 
    end;


    procedure VerifTaxe(Vehicule: Record "Véhicule"; DateRep: Date; DateFrep: Date) Vartaxe: Boolean
    begin
        Taxe.Reset;
        Taxe.SetRange("N° Véhicule", Vehicule."N° Vehicule");
        if Taxe.Find('+') then
            if (DateRep >= Taxe."Date fin Validité") or (DateFrep >= Taxe."Date fin Validité") then
                Vartaxe := true
            else
                Vartaxe := false;
    end;


}

