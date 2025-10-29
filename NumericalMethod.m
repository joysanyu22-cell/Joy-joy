classdef NumericalMethod
    %NUMERICALMETHOD Abstract Superclass for numerical computation problems.
    %   Encapsulates common parameters and defines abstract methods.

    properties (Access = protected)
        % Encapsulation: Parameters are protected, accessible by subclasses
        m = 80;
        g = 9.81;
        c = 0.25;
        mg; % m*g
    end

    methods (Abstract)
        % Abstraction & Polymorphism: Subclasses must implement these specific
        % solution methods.
        solution = solveNRM(obj, initialGuess, tolerance, maxIter);
        solution = solveSecant(obj, x0, x1, tolerance, maxIter);
        solution = solveEuler(obj, initialValue, stepSize, timeEnd);
        solution = solveRungeKutta(obj, initialValue, stepSize, timeEnd);
    end

    methods
        % Constructor for the Superclass
        function obj = NumericalMethod()
            obj.mg = obj.m * obj.g;
        end

        % Encapsulation: Common functions used by subclasses
        function val = f(obj, v)
            % f(v) = m*g - c*v^2
            val = obj.mg - obj.c * v^2;
        end

        function val = f_prime(obj, v)
            % f'(v) = -2*c*v
            val = -2 * obj.c * v;
        end
    end

    % Define differential equation function for integral methods (Euler/RK)
    % This represents the derivative dv/dt = f(v)
    methods (Static)
        function dvdt = differentialEq(t, v) %#ok<INUSD>
            % The differential equation dv/dt is the function f(v) used
            % in the NRM/Secant problems, representing the force balance.
            % For this specific problem: f(v) = 784.8 - 0.25*v^2
            m = 80; g = 9.81; c = 0.25;
            dvdt = m*g - c*v^2;
        end
    end
end