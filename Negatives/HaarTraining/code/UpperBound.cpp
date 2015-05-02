/*
 * UpperBound.cpp
 *
 *  Created on: May 1, 2015
 *      Author: CyrusAnderson
 */

#include "UpperBound.h"
#include <assert.h>

using namespace std;

UpperBound::UpperBound(double _fudgeFactor, double _factorDecay, double _thresholds[], double _im_height) :
	fudgeFactor(_fudgeFactor), factorDecay(_factorDecay), im_height(_im_height) {
	int len = 9;//sizeof(_thresholds)/sizeof(_thresholds[0]);
	assert(len == 9);
	//std::copy(thresholds, thresholds+9, _thresholds);
	for (int i=0; i<len; ++i) {
		thresholds[i] = _thresholds[i];
	}
}

bool UpperBound::passesRule(Rect bb) {
	double pixel_distance_im_to_bb = im_height - bb.y - bb.height;
	for (int i=0; i<8; ++i) {
		if (pixel_distance_im_to_bb < (i+1)*30) {
			return bb.height < thresholds[i] + fudgeFactor - factorDecay*i;
		}
	}
	return bb.height < thresholds[8] + fudgeFactor - factorDecay*8;
}

UpperBound::~UpperBound() {
	// TODO Auto-generated destructor stub
}

UpperBound::UpperBound(const UpperBound& _rhs) : fudgeFactor(_rhs.fudgeFactor),
		factorDecay(_rhs.factorDecay), im_height(_rhs.im_height) {
	//copy(thresholds, thresholds+9, _rhs.thresholds);
	int len = 9;//sizeof(_rhs.thresholds)/sizeof(_rhs.thresholds[0]);
	for (int i=0; i<len; ++i) {
		thresholds[i] = _rhs.thresholds[i];
	}
}

