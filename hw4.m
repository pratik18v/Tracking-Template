clc; clear all; close all;

path_to_car_sequence = 'CarSequence/';
sigma = 10;  %try for range 1 to 10
template='car_template.jpg';    %try other vehicle templates as well


trackTemplate(path_to_car_sequence, sigma, template);