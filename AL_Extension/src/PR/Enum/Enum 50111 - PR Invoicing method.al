enum 50111 "Dys invoicing method"
{
    Extensible = true;

    value(0; "Direct")
    {
        Caption = 'Direct';
    }
    value(1; Scheduler)
    {
        Caption = 'Scheduler';
    }
    value(2; Completion)
    {
        Caption = 'Completion';
    }
}