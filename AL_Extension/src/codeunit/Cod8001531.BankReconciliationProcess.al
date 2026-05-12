Codeunit 8001531 "Bank Reconciliation Process"
{
    //GL2024  ID dans Nav 2009 : "8001610"
    // PROTECTED


    trigger OnRun()
    begin
    end;

    var
        BankAccount: Record "Bank Account";
        Rappro: Record "BAR : Bank Entry";
        RapprBqe: Record "Bank Acc. Reconciliation";
        LigRapprBqe: Record "Bank Acc. Reconciliation Line";
        LoiRappro: Record "BAR : Reconciliation Rule";
        EcrBancaire: Record "Bank Account Ledger Entry";
        ModeRappro: Record "BAR : Reconciliation Mode";
        ParamRappro: Record "BAR : Setup";
        CpteBqeDefNumReleve: Codeunit "Bank Acc. Entry Set Recon.-No.";
        DateDebut: Date;
        DateFin: Date;
        DateFiltreDebut: Date;
        DateFiltreFin: Date;
        Trouv: Boolean;
        Fenetre: Dialog;
        CptrLig: Integer;
        NbreEnreg: Integer;
        NbrePasse: Integer;
        i: Integer;
        NbreEnregLu: Integer;
        NbreRappro: Integer;
        Text10000: label 'Please enter the ending date.';
        Text10001: label 'You must inform the default bank in reconciliation setup.';
        Text10002: label 'There''s nothing to reconciliate at %1.';
        Text10003: label 'The reconciliation is finished at %1.\Number or reading records %2\Number of reconcilied records %3 ( %4 %5 ).';
        Text10004: label 'Automatic reconciliation ...\Bank account           #1##########\Number of iterations   #2##########\Entry to reconciliate  #3##########\';


    procedure InitValue(var pRapprBqe: Record "Bank Acc. Reconciliation"; var pDateFin: Date)
    var
        lCheckLicenseMgt: Codeunit "Check Licence Management";
    begin
        //GL2024    PROTECTED
    end;


    procedure "Code"()
    begin
        //GL2024   PROTECTED
    end;


    procedure ProcessEntry()
    begin
        //GL2024     PROTECTED
    end;

    local procedure EntrerLigCpteBqe(Rappro2: Record "BAR : Bank Entry"; Last: Boolean)
    begin
        //GL2024   PROTECTED
    end;


    procedure InitRequete(NouvDateDebut: Date; NouvDateFin: Date; NouvInclureCheques: Boolean)
    begin
        //GL2024   PROTECTED
    end;


    procedure RechercheEcrBancaire(Rappro2: Record "BAR : Bank Entry")
    begin
        //GL2024     PROTECTED
    end;


    procedure RechercheLoi(Soc: Text[30]; NoCompte: Code[20]; Motif: Code[10]; Rappro2: Record "BAR : Bank Entry") Trouve: Boolean
    var
        DocFilter: Text[50];
        DocFilter2: Text[50];
    begin
        //GL2024    PROTECTED
    end;


    procedure MajLigneSimple(EcrBqe: Record "Bank Account Ledger Entry")
    begin
        //GL2024      PROTECTED
    end;


    procedure CalculTotMntOpe(Rappro2: Record "BAR : Bank Entry")
    var
        TotalMnt: Decimal;
        Rappro3: Record "BAR : Bank Entry";
        NbreEcr: Integer;
        EcrBque: Record "Bank Account Ledger Entry";
    begin
        //GL2024    PROTECTED
    end;


    procedure CalculTotMntVal(Rappro2: Record "BAR : Bank Entry")
    var
        TotalMnt: Decimal;
        Rappro3: Record "BAR : Bank Entry";
        NbreEcr: Integer;
        EcrBque: Record "Bank Account Ledger Entry";
    begin
        //GL2024    PROTECTED
    end;


    procedure CalculDate(Rappro2: Record "BAR : Bank Entry")
    begin
        //GL2024   PROTECTED
    end;


    procedure MajLigneTotaux(EcrBqe: Record "Bank Account Ledger Entry")
    begin
        //GL2024    PROTECTED
    end;
}

