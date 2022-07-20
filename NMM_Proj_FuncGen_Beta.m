%Nummerical methods and modeling
%By Zakary Williams

%This piece of software is meant to simulate the function of a 4 mode signal generator
%It will output a sin, square, sawtooth and triangle wave respectivly 
%The user can input the desired waveform, amplitude, frequency, and amount of harmonics to be generated.
%The system will output the waveform desired, the differential between the pure wave and the waveform desired and the pure wave
%Then the system will output the error between those signals. 

%Enjoy!

clear,clc,clf
summ=0;summit=0;T=1;w0=2*pi/T;tp=-1:1/256:1;

instrTxt = 'Welcome to the Williams-Bergh function generator, Please specify the waveform, amplitude, frequency and accuracy of the signal you would like.';
prompt1 = 'Enter amplitude:';
prompt2 = 'Enter frequency (100-10000)';
prompt3 = 'Enter desired waveform to generate:';
prompt4 = 'Enter number of harmonics desired:';
dlgtitle = 'Waveform generator input:';

startTxt = msgbox(instrTxt,dlgtitle);
waveFrm = string(inputdlg(prompt3,dlgtitle));
Ns = str2double(inputdlg(prompt4,dlgtitle));
Am = str2double(inputdlg(prompt1,dlgtitle));
F = str2double(inputdlg(prompt2,dlgtitle));

waveFrm;

switch lower(waveFrm)

    case 'sine'
        % Output sine wave, a sine wave is a perfect waveform that has no
        % harmonics therefor there will be no distortion
        summ= Am*sin(w0*tp*F/2);
        summit = summ;
    case 'square'
        % Output square wave, this function will have the highest chance of
        % distortion since it requires many more harmonics to make up the 
        % sharp edges. This is built using the Fourier series expansion 
        for i = 1:5000+Ns
          if mod(i,2) == 1
            term=Am*4/(i*pi)*sin(i/2*w0*tp*F);
            summ=summ+term;
          else
          end
          if i == (Ns*2)
            summit = summ;
          end
        end
    case {'saw','sawtooth'}
        % Output saw/sawtooth wave, a right angle trangle wave, made using
        % the Fourier series expansion equation. 
        for i = 1:5000+Ns
          if mod(i,2) == 1
          else
            term=Am*4/(i*pi)*sin(i/2*w0*tp*F);
            summ=summ+term;
          end
          if i == (Ns*2)
            summit = summ;
          end
        end 
    case 'triangle'
        % Output triangle wave, using Fourier series expansion equation
        for i = 1:5000+Ns
              term=((-4*Am)/((2*i-1)^2*pi^2))*cos((2*i-1)*w0*tp*F);
              summ=summ+term;
        if i == (Ns)
            summit = (Am/2)+summ;
        end
        end 
        summ = (Am/2)+summ;
    otherwise
        msgbox("Not a usable input", dlgtitle);
end
diff = (summit - summ);
er = (trapz((F),abs(diff))/trapz((F),abs(summ)))*100;
errorTxt = sprintf('The differential error between the fourier representation of the signal and the pure signal is %d percent', er);
msgbox(errorTxt,dlgtitle);
plot(tp,summit,tp,summ,tp,diff,'linewidth',2) 
 
