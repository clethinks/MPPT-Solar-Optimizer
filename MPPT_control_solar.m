function duty = MPPT_control( V, I,deltaD_in)

duty_init = 0.05;
duty_min=0;
duty_max=0.75;

persistent Vold Pold duty_old;

if isempty(Vold)
    Vold=0;
    Pold=0;
    duty_old=duty_init;
end
P= V*I;
dV= V - Vold;
dP= P - Pold;
duty = duty_old;
deltaD=deltaD_in;

if dP ~= 0
    if dP < 0
        if dV < 0
            duty = duty_old - deltaD;
        else
            duty = duty_old + deltaD;
        end
    else
        if dV < 0
            duty = duty_old + deltaD;
        else
            duty = duty_old - deltaD;
        end
    end
end

if duty >= duty_max
    duty=duty_max;
elseif duty<duty_min
    duty=duty_min;
end

duty_old=duty;
Vold=V;
Pold=P;
